#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <unistd.h>
#include <time.h>

#define BUFSIZE 512
/*
char* itoa(int i, char b[]){
    char const digit[] = "0123456789";
    char* p = b;
    if(i<0){
        *p++ = '-';
        i *= -1;
    }
    int shifter = i;
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
    }while(shifter);
    *p = '\0';
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    return b;
}*/

int main(int argc, char **argv){
	
	int sfd, s,r;
  struct addrinfo hints;
  struct addrinfo *result, *rp;
  char buf[BUFSIZE];
  struct sockaddr_storage from;
  socklen_t fromlen;
  //char host[NI_MAXHOST];
  struct servent *serv;
  char * heure;
  //char service[NI_MAXSERV];
	//char b[20];
	char * service_name = "daytime";
	char * service_proto = "udp";
	printf("test");
	serv = getservbyname(service_name,service_proto);
	printf(" le serveur tourne sur l port %d",serv->s_port);
  /* Construction de l'adresse locale (pour bind) */
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_family = AF_INET;           /* Force IPv6 */
  hints.ai_socktype = SOCK_DGRAM;      /* Stream socket */
  hints.ai_flags = AI_PASSIVE;          /* Adresse IP joker */
  hints.ai_flags |= AI_V4MAPPED|AI_ALL; /* IPv4 remapped en IPv6 */
  hints.ai_protocol = 0;                /* Any protocol */

  
  s = getaddrinfo(NULL, "3328", &hints, &result);
  if (s != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(s));
    exit(EXIT_FAILURE);
  }

  /* getaddrinfo() retourne une liste de structures d'adresses.
     On essaie chaque adresse jusqu'a ce que bind(2) reussisse.
     Si socket(2) (ou bind(2)) echoue, on (ferme la socket et on)
     essaie l'adresse suivante. cf man getaddrinfo(3) */
  for (rp = result; rp != NULL; rp = rp->ai_next) {

    /* Creation de la socket */
    sfd = socket(PF_INET,SOCK_DGRAM,0);//? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
    if (sfd == -1)
      continue;

    /* Association d'un port a la socket */
    r = bind(sfd, rp->ai_addr, rp->ai_addrlen);//? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
    if (r == 0)
      break;            /* Succes */
    close(sfd);
  }

  if (rp == NULL) {     /* Aucune adresse valide */
    perror("bind");
    exit(EXIT_FAILURE);
  }
  freeaddrinfo(result); /* Plus besoin */

	// obteltion de l'heure actuelle
	time_t  *t=NULL;
	 time(t);
	heure = ctime(t);
	//communication
	fromlen = sizeof(from);
	recvfrom(sfd,buf,BUFSIZE, MSG_WAITALL,(struct sockaddr *)&from, &fromlen);	
	
	/* Reconnaissance de la machine cliente */
  /*  s = getnameinfo((struct sockaddr *)&from, fromlen,
			host, NI_MAXHOST, service, NI_MAXSERV,
			NI_NUMERICHOST | NI_NUMERICSERV);
    if (s == 0)
      printf("Emetteur '%s'  Port '%s'\n", host, service);
    else
      printf("Erreur: %s\n", gai_strerror(s));
    */  
    sendto(sfd,heure,sizeof(heure),MSG_NOSIGNAL,(struct sockaddr *)&from,fromlen);
  
}

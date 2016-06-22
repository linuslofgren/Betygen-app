#include <stdio.h>
#include <stdlib.h>

//there are many people in the world.
int lengthL(FILE*);
char* fileToStr(FILE*);
int find(char*, char*);
int findOffset(int, char*, char*);
int lengthS(char*);
int strToInt(char*);
int charToInt(char);
int getIntAfterInStr(char*, char*);
int getAllInStringAfterStr(char*,char*);

int main(int argc, char const *argv[]) {
  FILE* fp;
  fp = fopen("../DATA/betyg.json", "ra");
  char* str = fileToStr(fp);
  //
  //int tot = getAllInStringAfterStr(str, "STOCK");
  //
  //printf("%i\n", tot);

  return 0;
}

char* fileToStr(FILE* fp){
  int l = lengthL(fp);
  char* ch= malloc(l * sizeof(char));
  for (int i = 0; i < l; i++) {
    ch[i] = getc(fp);
    if(ch[i] == EOF){
      ch[i] = '\0';
      break;
    }
  }
  return ch;
}

int find(char* str1, char* str2){
  int i = 0;
  for (;;) {
    if(str1[i]=='\0'){
      break;
    }
    for (int j = 0; j < lengthS(str2); j++) {
      if(str1[i+j]!=str2[j]){
        break;
      }
      if(j==lengthS(str2)-1){
        return i;
      }
    }
    i++;
  }
  return -1;
}

int findOffset(int start, char* str1, char* str2){
  return find(&str1[start], str2);
}

int lengthL(FILE* fp){
  int length = 0;
  for(;;){
    length++;
    if(getc(fp) == EOF){
      rewind(fp);
      return length;
    }
  }
}

int lengthS(char* str){
  int l = 0;
  for (;;) {
    if(str[l]=='\0'){
      return l;
    }
    l++;
  }
}

int strToInt(char* str){
  int tot = 0;
  int c = 0;
  for (int i = 0; i < lengthS(str); i++) {
    int val = charToInt(str[i]);
    if(val == -1){
      if(c == 0){
        return -1;
      }
      return tot;
    }
    else{
      tot = tot * 10 + val;
    }
    c = c + 1;
  }
  return tot;
}

int charToInt(char ch){
  if(ch-48<0||ch-48>9){
    return -1;
  }
  return ch-48;
}

int getIntAfterInStr(char* str, char* str1){
  int index = find(str, str1);
  int calc = index+lengthS(str1);
  return strToInt(&str[calc]);
}

int getAllInStringAfterStr(char* str, char* str1){
  int Itot = 0;
  int tot = 0;
  for (int i = 0; i < lengthS(str); i++) {
    int b = findOffset(tot, str, str1);
    tot = tot + b + 1;
    if(b == -1){
      break;
    }
    int a = getIntAfterInStr(&str[tot-1], str1);
    if(a > -1){
      //printf("%i\n", a);
      Itot = Itot + a;
    }
  }
  return Itot;
}

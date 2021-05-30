#!/bin/bash

USERNAME="" #username github kamu
PASSWORD="" #password github kamu
SOURCE="" #ini diisi dengan username atau origanisasi pemilik repositorinya
REPO="" #nama repositorinya
BRANCH="" #nama branchnya yang mau di pull, contohnya : "master" atau "development"

GIT_DIRECTORY="" #instalasi repo tujuan, contoh : "/var/www/html/repoku"

IS_SEND_EMAIL=true #jika false, maka email tidak terkirim, namun aksi clone atau pull akan tetap dijalankan
SEND_EMAIL_TO="" #email penerima, conto : akbarsatrio@outlook.co.id

if [ -d $GIT_DIRECTORY".git" ]; then
  echo "Folder .git ditemukan, saatnya pull dari master..."
  LAST_RESPONSE=$(git pull https://$USERNAME:$PASSWORD@github.com/$SOURCE/$REPO.git $BRANCH)
  if [ "$IS_SEND_EMAIL" = true ]; then
      echo "Pull dari master sukses, saatnya kirim notifikasi ke email"
      echo -e "Pull Success, The system will retract the next day!\n\n $LAST_RESPONSE" | mailx -s "Status GIT Pull From Repo $REPO" $SEND_EMAIL_TO
  else
      echo "Pull dari master sukses"
  fi
  echo "Selesai"
else
  echo "Folder .git tidak ditemukan, saatnya cloning..."
  LAST_RESPONSE=$(git clone https://$USERNAME:$PASSWORD@github.com/$SOURCE/$REPO.git)
  if [ "$IS_SEND_EMAIL" = true ]; then
      echo "Clone dari sukses, saatnya kirim notifikasi ke email"
      echo -e "Clone Success, The Git Pull will retract the next day!\n\n $LAST_RESPONSE" | mailx -s "Status GIT Clone From Repo $REPO" $TO
  else
      echo "Clone dari sukses"
  fi
  echo "Selesai"
fi

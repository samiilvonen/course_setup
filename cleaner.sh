
cd ~/.ssh
rm authorized_keys
cat id_dsa.pub > authorized_keys
cat id_rsa_taito.pub >> authorized_keys
chmod 600 authorized_keys


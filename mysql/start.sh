/usr/bin/mysqld_safe &

until $(mysqladmin ping > /dev/null 2>&1)
do
    :
done

mysqladmin -u $USER password $PASS
mysql -u $USER -p$PASS <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASS' WITH GRANT OPTION;
EOF

mysqladmin -p$PASS shutdown
/usr/bin/mysqld_safe


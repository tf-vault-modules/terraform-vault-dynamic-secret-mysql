# FAQ

## What if I already have database secret engine enabled?

You can always import it.

```
terraform import module.vault_dynamic_secret_mysql.vault_mount.db YOUR_MOUNT_PATH
```

Or you can use *existing_engine* argument set to true ([Existing engine example](<https://github.com/tf-vault-modules/terraform-vault-dynamic-secrets-mysql/blob/7cf8071526b201974cf8d50913da2bdac1275549/examples/existing-engine/main.tf#LL19C3-L19C18>))

## How can I restrict role to only one database?

Use creation_statements for that role ([Basic example](<https://github.com/tf-vault-modules/terraform-vault-dynamic-secrets-mysql/blob/5729abb21eb00c8b84ee6b53eec1ef0523998e8e/examples/basic/main.tf#L36>))

## Do I have to prepare MySQL/MariaDB vault-admin user?

Absolutely! For test purposes, try to use following statements in your MySQL:

```SQL
DROP USER IF EXISTS 'vault-admin'@'%';
CREATE DATABASE IF NOT EXISTS `test-db`;
CREATE USER 'vault-admin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'vault-admin'@'%' WITH GRANT OPTION;
```

and use test-db in your module call.

## What is going to happen if I don't have specified database in MySQL?

This module will still generate user but it won't be able to do much.

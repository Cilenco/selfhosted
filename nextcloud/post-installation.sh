#!/bin/bash

#################################################
# Setup basic config                            #
#################################################
php occ config:system:set allow_local_remote_servers --type="boolean" --value="true"

php occ config:system:set trusted_domains 2 --type="string" --value="cloud.$DOMAIN"

php occ config:system:set default_language --type="string" --value="de"
php occ config:system:set default_phone_region --type="string" --value="DE"
php occ config:system:set default_locale --type="string" --value="de_DE"

php occ config:system:set default_timezone --type="string" --value="Europe/Berlin"

php occ config:system:set hide_login_form --type="boolean" --value="false"
php occ config:system:set updatechecker --type="boolean" --value="false"

php occ config:system:set defaultapp --type="string" --value="files"

#"files.chunked_upload.max_size" => 4 * 1024 * 1024 * 1024, // 4 GB

#################################################
# Configure additional apps                     #
#################################################

php occ app:install calendar
php occ app:install contacts
php occ app:install user_oidc
php occ app:install user_ldap

php occ app:install unroundedcorners

php occ app:disable dashboard
php occ app:disable weather_status
php occ app:disable user_status

#################################################
# Setup LDAP                                    #
#################################################
BASE_DN="dc=example,dc=com"

php occ ldap:create-empty-config

php occ ldap:set-config s01 ldapHost "ldap://ldap"
php occ ldap:set-config s01 ldapPort 3890

# EDIT: admin user
php occ ldap:set-config s01 ldapAgentName "uid=$LDAP_USERNAME,ou=people,$BASE_DN"
php occ ldap:set-config s01 ldapAgentPassword "$LDAP_PASSWORD"

# Set LDAP admin group as admins in Nextcloud
php occ ldap:promote-group  "admin"

# EDIT: Base DN
php occ ldap:set-config s01 ldapBase "$BASE_DN"
php occ ldap:set-config s01 ldapBaseUsers "$BASE_DN"
php occ ldap:set-config s01 ldapBaseGroups "$BASE_DN"

php occ ldap:set-config s01 ldapConfigurationActive 1
php occ ldap:set-config s01 ldapLoginFilter "(&(objectclass=person)(uid=%uid))"

# EDIT: nextcloud_users group, contains the users who can login to Nextcloud
php occ ldap:set-config s01 ldapUserFilter "(&(objectclass=person)(memberOf=cn=nextcloud,ou=groups,$BASE_DN))"
php occ ldap:set-config s01 ldapUserFilterMode 0
php occ ldap:set-config s01 ldapUserFilterObjectclass person
php occ ldap:set-config s01 turnOnPasswordChange 0
php occ ldap:set-config s01 ldapCacheTTL 600
php occ ldap:set-config s01 ldapExperiencedAdmin 0
php occ ldap:set-config s01 ldapGidNumber gidNumber

# EDIT: list of application groups
php occ ldap:set-config s01 ldapGroupFilter "(&(objectclass=groupOfUniqueNames)(|(cn=friends)(cn=family)))"

# EDIT: list of application groups
php occ ldap:set-config s01 ldapGroupFilterGroups "friends;family"
php occ ldap:set-config s01 ldapGroupFilterMode 0
php occ ldap:set-config s01 ldapGroupDisplayName cn
php occ ldap:set-config s01 ldapGroupFilterObjectclass groupOfUniqueNames
php occ ldap:set-config s01 ldapGroupMemberAssocAttr uniqueMember
php occ ldap:set-config s01 ldapEmailAttribute "mail"
php occ ldap:set-config s01 ldapLoginFilterEmail 0
php occ ldap:set-config s01 ldapLoginFilterUsername 1
php occ ldap:set-config s01 ldapMatchingRuleInChainState unknown
php occ ldap:set-config s01 ldapNestedGroups 0
php occ ldap:set-config s01 ldapPagingSize 500
php occ ldap:set-config s01 ldapTLS 0
php occ ldap:set-config s01 ldapUserAvatarRule default
php occ ldap:set-config s01 ldapUserDisplayName displayname
php occ ldap:set-config s01 ldapUserFilterMode 1
php occ ldap:set-config s01 ldapUuidGroupAttribute auto
php occ ldap:set-config s01 ldapExpertUsernameAttr user_id
php occ ldap:set-config s01 ldapUuidUserAttribute auto

#################################################
# Setup Authelia authentication                 #
#################################################

php occ user_oidc:provider authelia \
    --clientid="nextcloud" --clientsecret=$CLIENT_SECRET \
    --discoveryuri="https://auth.$DOMAIN/.well-known/openid-configuration"

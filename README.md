# PapaSys

Created with Phoenix Installer v1.7.11

Created via this command line:
`mix phx.new papa_cc --no-assets --no-dashboard --no-html --no-mailer --database sqlite3`

* No assets since there is no need for a web UI
* No dashboard since there is no web UI and this also cuts down on potential attack surface
* No HTML since there is no web UI
* No mailer since there is no need for email functionality

# Assumptions

I've made a few simplifying assumptions for this project and I want to document them here.

1. There is no need for password protection on either the members or the pals.
2. In a production system I would likely supply both a REST API and a GraphQL API, but for this project I'm only supplying a REST API.
3. I'm assuming that emails cannot be duplicated.  This precludes someone from changing the name associated with an email address.
4. I'm assuming that I do not need to support a soft delete for member or pal accounts.  When I'm told to remove a pal or member account it's gone with no recovery.  If they have a balance of time or money it's gone. 

# Use Cases

In order to help guide my development efforts I've created a few use cases that I want to support. I'll document them here.

## Client

1. I need to be able to create a new member, a new pal or a new user that fulfills both of those roles.
    * _(Simplifying assumption)_ I do not need to confirm the email address is real.
    * Unhappy paths to address:
      1. No first or last name provided
      2. No email provided
      3. Attempting to set a negative beginning balance.

2. I need to be able to update a member, a pal or a user that fulfills both of those roles. 
    * Updating use cases:
        1. Changing the name of the member or pal
        2. Changing the balance associated with a member or pal.
  
3. I need to be able to retrieve a list of all members, all pals or all members who are also pals as well as a full list of every client of the system.

4. I need to be able to delete a member or pal. 

## Visit
1. I need to be able to request a visit for a member.
  * The requesting member cannot request a visit more than 1.15 times his/her current minute balance.
  * _(Simplifying assumption)_ The requesting member cannot request a visit from a specific pal.
  * _(Simplifying assumption)_ The visit cannot be requested for a date prior to today.  While this may actually be needed for some sort of accounting purposes (an adjusting entry maybe?) I'm going to ignore that for now.

## Transaction
1. I need to be able to create a transaction involving a specified member and a specified pal.

# Testing the REST API
Refer to the [TESTING.md](./TESTING.Md) file for details on how to test the REST API.

CREATE VIEW [dbo].[01-Users]
AS
SELECT        TOP (100) PERCENT dbo.aspnet_Users.UserName, dbo.aspnet_Membership.Password, dbo.aspnet_UsersInRoles.RoleId, dbo.aspnet_Roles.RoleName, 
                         dbo.CF_Profile_Contact.LastName, dbo.CF_Profile_Contact.FirstName, dbo.CF_Profile_Contact.IDProfileAccount, dbo.CF_Profile_Account.AccountName
FROM            dbo.aspnet_Users INNER JOIN
                         dbo.aspnet_Membership ON dbo.aspnet_Users.UserId = dbo.aspnet_Membership.UserId INNER JOIN
                         dbo.aspnet_UsersInRoles ON dbo.aspnet_Users.UserId = dbo.aspnet_UsersInRoles.UserId INNER JOIN
                         dbo.aspnet_Roles ON dbo.aspnet_UsersInRoles.RoleId = dbo.aspnet_Roles.RoleId INNER JOIN
                         dbo.CF_Profile_Contact ON dbo.aspnet_Users.UserId = dbo.CF_Profile_Contact.UserID INNER JOIN
                         dbo.CF_Profile_Account ON dbo.CF_Profile_Contact.IDProfileAccount = dbo.CF_Profile_Account.IDProfileAccount
ORDER BY dbo.aspnet_Users.UserName

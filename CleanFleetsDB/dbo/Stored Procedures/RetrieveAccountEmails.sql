
CREATE PROCEDURE [dbo].[RetrieveAccountEmails]

	@IDProfileAccount	int

AS

BEGIN

	SELECT DISTINCT
			CF_Profile_Account.AccountName,
			ISNULL(CF_Profile_Contact.FirstName + ' ' + CF_Profile_Contact.LastName, '') [FullName],
			aspnet_Membership.LoweredEmail [Email]
		FROM
			CF_Profile_Account LEFT JOIN CF_Profile_Contact ON
					CF_Profile_Account.IDProfileAccount = CF_Profile_Contact.IDProfileAccount
				LEFT JOIN CF_UserTerminals ON
					CF_UserTerminals.UserID = CF_Profile_Contact.UserID AND
					CF_UserTerminals.PermissionLevel LIKE '[AB]'
				LEFT JOIN aspnet_Membership ON
					CF_Profile_Contact.UserID = aspnet_Membership.UserId
		WHERE
			CF_Profile_Account.IDProfileAccount = @IDProfileAccount
		ORDER BY
			CF_Profile_Account.AccountName
END

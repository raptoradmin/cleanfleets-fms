
CREATE PROCEDURE [dbo].[RetrieveImapConfiguration]

AS

BEGIN

	SELECT
			aspnet_Membership.LoweredEmail [Email],
			IMAPUsername,
			IMAPPassword,
			IMAPDraftsFolder
		FROM
			CF_Profile_Contact INNER JOIN aspnet_Membership ON
					CF_Profile_Contact.UserID = aspnet_Membership.UserId
				INNER JOIN Config ON
					CF_Profile_Contact.IDProfileContact = CAST(Config.ParameterValue AS int)
END

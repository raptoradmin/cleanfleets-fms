using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using FMS.Repository.Models;
namespace FMS.Repository
{
    public partial class FMSRepoContext : DbContext
    {
        public virtual DbSet<AggregatedCounter> AggregatedCounter { get; set; }
        public virtual DbSet<AspnetApplications> AspnetApplications { get; set; }
        public virtual DbSet<AspnetMembership> AspnetMembership { get; set; }
        public virtual DbSet<AspnetPaths> AspnetPaths { get; set; }
        public virtual DbSet<AspnetPersonalizationAllUsers> AspnetPersonalizationAllUsers { get; set; }
        public virtual DbSet<AspnetPersonalizationPerUser> AspnetPersonalizationPerUser { get; set; }
        public virtual DbSet<AspnetProfile> AspnetProfile { get; set; }
        public virtual DbSet<AspnetRoles> AspnetRoles { get; set; }
        public virtual DbSet<AspnetSchemaVersions> AspnetSchemaVersions { get; set; }
        public virtual DbSet<AspnetUsers> AspnetUsers { get; set; }
        public virtual DbSet<AspnetUsersInRoles> AspnetUsersInRoles { get; set; }
        public virtual DbSet<AspnetWebEventEvents> AspnetWebEventEvents { get; set; }
        public virtual DbSet<CfAccountDefaultModules> CfAccountDefaultModules { get; set; }
        public virtual DbSet<CfComplianceMilestones> CfComplianceMilestones { get; set; }
        public virtual DbSet<CfCustomModule> CfCustomModule { get; set; }
        public virtual DbSet<CfCustomModuleContents> CfCustomModuleContents { get; set; }
        public virtual DbSet<CfDecs> CfDecs { get; set; }
        public virtual DbSet<CfEngines> CfEngines { get; set; }
        public virtual DbSet<CfFiles> CfFiles { get; set; }
        public virtual DbSet<CfImages> CfImages { get; set; }
        public virtual DbSet<CfMenuConsole> CfMenuConsole { get; set; }
        public virtual DbSet<CfOptionList> CfOptionList { get; set; }
        public virtual DbSet<CfProfileAccount> CfProfileAccount { get; set; }
        public virtual DbSet<CfProfileContact> CfProfileContact { get; set; }
        public virtual DbSet<CfProfileFleet> CfProfileFleet { get; set; }
        public virtual DbSet<CfProfileTerminal> CfProfileTerminal { get; set; }
        public virtual DbSet<CfQeAccount> CfQeAccount { get; set; }
        public virtual DbSet<CfQeEstimate> CfQeEstimate { get; set; }
        public virtual DbSet<CfSignatures> CfSignatures { get; set; }
        public virtual DbSet<CfUserTerminals> CfUserTerminals { get; set; }
        public virtual DbSet<CfVehicles> CfVehicles { get; set; }
        public virtual DbSet<CfVehiclesLogHours> CfVehiclesLogHours { get; set; }
        public virtual DbSet<CfVehiclesLogHoursOld> CfVehiclesLogHoursOld { get; set; }
        public virtual DbSet<CfVehiclesLogMilageOld> CfVehiclesLogMilageOld { get; set; }
        public virtual DbSet<CfVehiclesLogMileage> CfVehiclesLogMileage { get; set; }
        public virtual DbSet<CfVehiclesLogOpacityTests> CfVehiclesLogOpacityTests { get; set; }
        public virtual DbSet<Config> Config { get; set; }
        public virtual DbSet<ConfigDsc> ConfigDsc { get; set; }
        public virtual DbSet<Counter> Counter { get; set; }
        public virtual DbSet<Hash> Hash { get; set; }
        public virtual DbSet<Job> Job { get; set; }
        public virtual DbSet<JobParameter> JobParameter { get; set; }
        public virtual DbSet<JobQueue> JobQueue { get; set; }
        public virtual DbSet<List> List { get; set; }
        public virtual DbSet<Schema> Schema { get; set; }
        public virtual DbSet<Server> Server { get; set; }
        public virtual DbSet<Set> Set { get; set; }
        public virtual DbSet<State> State { get; set; }

        // Unable to generate entity type for table 'dbo.CF_Menu_Client'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.Test'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.CF_Import'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.et'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.Table1'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(@"Data Source=localhost;Initial Catalog=CleanFleets;User ID=sa;Password=Cl3anFl33ts1");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AggregatedCounter>(entity =>
            {
                entity.ToTable("AggregatedCounter", "HangFire");

                entity.HasIndex(e => new { e.Value, e.Key })
                    .HasName("UX_HangFire_CounterAggregated_Key")
                    .IsUnique();

                entity.Property(e => e.ExpireAt).HasColumnType("datetime");

                entity.Property(e => e.Key)
                    .IsRequired()
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<AspnetApplications>(entity =>
            {
                entity.HasKey(e => e.ApplicationId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("aspnet_Applications");

                entity.HasIndex(e => e.ApplicationName)
                    .HasName("UQ__aspnet_Applicati__15DA3E5D")
                    .IsUnique();

                entity.HasIndex(e => e.LoweredApplicationName)
                    .HasName("aspnet_Applications_Index")
                    .ForSqlServerIsClustered();

                entity.Property(e => e.ApplicationId).HasDefaultValueSql("(newid())");

                entity.Property(e => e.ApplicationName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.Description).HasMaxLength(256);

                entity.Property(e => e.LoweredApplicationName)
                    .IsRequired()
                    .HasMaxLength(256);
            });

            modelBuilder.Entity<AspnetMembership>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("aspnet_Membership");

                entity.HasIndex(e => new { e.ApplicationId, e.LoweredEmail })
                    .HasName("aspnet_Membership_index")
                    .ForSqlServerIsClustered();

                entity.Property(e => e.UserId).ValueGeneratedNever();

                entity.Property(e => e.Comment).HasColumnType("ntext(3000)");

                entity.Property(e => e.CreateDate).HasColumnType("datetime");

                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.FailedPasswordAnswerAttemptWindowStart).HasColumnType("datetime");

                entity.Property(e => e.FailedPasswordAttemptWindowStart).HasColumnType("datetime");

                entity.Property(e => e.IdprofileContact).HasColumnName("IDProfileContact");

                entity.Property(e => e.LastLockoutDate).HasColumnType("datetime");

                entity.Property(e => e.LastLoginDate).HasColumnType("datetime");

                entity.Property(e => e.LastPasswordChangedDate).HasColumnType("datetime");

                entity.Property(e => e.LoweredEmail).HasMaxLength(256);

                entity.Property(e => e.MobilePin)
                    .HasColumnName("MobilePIN")
                    .HasMaxLength(16);

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.PasswordAnswer).HasMaxLength(128);

                entity.Property(e => e.PasswordFormat).HasDefaultValueSql("((0))");

                entity.Property(e => e.PasswordQuestion).HasMaxLength(256);

                entity.Property(e => e.PasswordSalt)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.HasOne(d => d.Application)
                    .WithMany(p => p.AspnetMembership)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Me__Appli__29E1370A");

                entity.HasOne(d => d.User)
                    .WithOne(p => p.AspnetMembership)
                    .HasForeignKey<AspnetMembership>(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Me__UserI__2AD55B43");
            });

            modelBuilder.Entity<AspnetPaths>(entity =>
            {
                entity.HasKey(e => e.PathId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("aspnet_Paths");

                entity.HasIndex(e => new { e.ApplicationId, e.LoweredPath })
                    .HasName("aspnet_Paths_index")
                    .IsUnique()
                    .ForSqlServerIsClustered();

                entity.Property(e => e.PathId).HasDefaultValueSql("(newid())");

                entity.Property(e => e.LoweredPath)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.Path)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.HasOne(d => d.Application)
                    .WithMany(p => p.AspnetPaths)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Pa__Appli__5B78929E");
            });

            modelBuilder.Entity<AspnetPersonalizationAllUsers>(entity =>
            {
                entity.HasKey(e => e.PathId);

                entity.ToTable("aspnet_PersonalizationAllUsers");

                entity.Property(e => e.PathId).ValueGeneratedNever();

                entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");

                entity.Property(e => e.PageSettings)
                    .IsRequired()
                    .HasColumnType("image(6000)");

                entity.HasOne(d => d.Path)
                    .WithOne(p => p.AspnetPersonalizationAllUsers)
                    .HasForeignKey<AspnetPersonalizationAllUsers>(d => d.PathId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Pe__PathI__61316BF4");
            });

            modelBuilder.Entity<AspnetPersonalizationPerUser>(entity =>
            {
                entity.ToTable("aspnet_PersonalizationPerUser");

                entity.HasIndex(e => new { e.PathId, e.UserId })
                    .HasName("aspnet_PersonalizationPerUser_index1")
                    .IsUnique()
                    .ForSqlServerIsClustered();

                entity.HasIndex(e => new { e.UserId, e.PathId })
                    .HasName("aspnet_PersonalizationPerUser_ncindex2")
                    .IsUnique();

                entity.Property(e => e.Id).HasDefaultValueSql("(newid())");

                entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");

                entity.Property(e => e.PageSettings)
                    .IsRequired()
                    .HasColumnType("image(6000)");

                entity.HasOne(d => d.Path)
                    .WithMany(p => p.AspnetPersonalizationPerUser)
                    .HasForeignKey(d => d.PathId)
                    .HasConstraintName("FK__aspnet_Pe__PathI__6501FCD8");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspnetPersonalizationPerUser)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__aspnet_Pe__UserI__65F62111");
            });

            modelBuilder.Entity<AspnetProfile>(entity =>
            {
                entity.HasKey(e => e.UserId);

                entity.ToTable("aspnet_Profile");

                entity.Property(e => e.UserId).ValueGeneratedNever();

                entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");

                entity.Property(e => e.PropertyNames)
                    .IsRequired()
                    .HasColumnType("ntext(6000)");

                entity.Property(e => e.PropertyValuesBinary)
                    .IsRequired()
                    .HasColumnType("image(6000)");

                entity.Property(e => e.PropertyValuesString)
                    .IsRequired()
                    .HasColumnType("ntext(6000)");

                entity.HasOne(d => d.User)
                    .WithOne(p => p.AspnetProfile)
                    .HasForeignKey<AspnetProfile>(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Pr__UserI__3EDC53F0");
            });

            modelBuilder.Entity<AspnetRoles>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("aspnet_Roles");

                entity.HasIndex(e => new { e.ApplicationId, e.LoweredRoleName })
                    .HasName("aspnet_Roles_index1")
                    .IsUnique()
                    .ForSqlServerIsClustered();

                entity.Property(e => e.RoleId).HasDefaultValueSql("(newid())");

                entity.Property(e => e.Description).HasMaxLength(256);

                entity.Property(e => e.LoweredRoleName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.RoleName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.HasOne(d => d.Application)
                    .WithMany(p => p.AspnetRoles)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Ro__Appli__4865BE2A");
            });

            modelBuilder.Entity<AspnetSchemaVersions>(entity =>
            {
                entity.HasKey(e => new { e.Feature, e.CompatibleSchemaVersion });

                entity.ToTable("aspnet_SchemaVersions");

                entity.Property(e => e.Feature).HasMaxLength(128);

                entity.Property(e => e.CompatibleSchemaVersion).HasMaxLength(128);
            });

            modelBuilder.Entity<AspnetUsers>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("aspnet_Users");

                entity.HasIndex(e => new { e.ApplicationId, e.LastActivityDate })
                    .HasName("aspnet_Users_Index2");

                entity.HasIndex(e => new { e.ApplicationId, e.LoweredUserName })
                    .HasName("aspnet_Users_Index")
                    .IsUnique()
                    .ForSqlServerIsClustered();

                entity.Property(e => e.UserId).HasDefaultValueSql("(newid())");

                entity.Property(e => e.LastActivityDate).HasColumnType("datetime");

                entity.Property(e => e.LoweredUserName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.MobileAlias).HasMaxLength(16);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.HasOne(d => d.Application)
                    .WithMany(p => p.AspnetUsers)
                    .HasForeignKey(d => d.ApplicationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Us__Appli__19AACF41");
            });

            modelBuilder.Entity<AspnetUsersInRoles>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId });

                entity.ToTable("aspnet_UsersInRoles");

                entity.HasIndex(e => e.RoleId)
                    .HasName("aspnet_UsersInRoles_index");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AspnetUsersInRoles)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Us__RoleI__4D2A7347");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspnetUsersInRoles)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__aspnet_Us__UserI__4C364F0E");
            });

            modelBuilder.Entity<AspnetWebEventEvents>(entity =>
            {
                entity.HasKey(e => e.EventId);

                entity.ToTable("aspnet_WebEvent_Events");

                entity.Property(e => e.EventId)
                    .HasColumnType("char(32)")
                    .ValueGeneratedNever();

                entity.Property(e => e.ApplicationPath).HasMaxLength(256);

                entity.Property(e => e.ApplicationVirtualPath).HasMaxLength(256);

                entity.Property(e => e.Details).HasColumnType("ntext");

                entity.Property(e => e.EventOccurrence).HasColumnType("decimal(19, 0)");

                entity.Property(e => e.EventSequence).HasColumnType("decimal(19, 0)");

                entity.Property(e => e.EventTime).HasColumnType("datetime");

                entity.Property(e => e.EventTimeUtc).HasColumnType("datetime");

                entity.Property(e => e.EventType)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.ExceptionType).HasMaxLength(256);

                entity.Property(e => e.MachineName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.Message).HasMaxLength(1024);

                entity.Property(e => e.RequestUrl).HasMaxLength(1024);
            });

            modelBuilder.Entity<CfAccountDefaultModules>(entity =>
            {
                entity.HasKey(e => e.IdaccountDefaultModules);

                entity.ToTable("CF_AccountDefaultModules");

                entity.Property(e => e.IdaccountDefaultModules).HasColumnName("IDAccountDefaultModules");

                entity.Property(e => e.IddefaultModule).HasColumnName("IDDefaultModule");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.IsDisplayed).HasColumnType("char(1)");
            });

            modelBuilder.Entity<CfComplianceMilestones>(entity =>
            {
                entity.HasKey(e => e.Idmilestones);

                entity.ToTable("CF_Compliance_Milestones");

                entity.Property(e => e.Idmilestones).HasColumnName("IDMilestones");

                entity.Property(e => e.MilestoneDate).HasColumnType("datetime");

                entity.Property(e => e.MilestoneDescription)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.MilestoneName)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfCustomModule>(entity =>
            {
                entity.HasKey(e => e.IdcustomModule);

                entity.ToTable("CF_CustomModule");

                entity.Property(e => e.IdcustomModule).HasColumnName("IDCustomModule");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.ModuleName)
                    .HasMaxLength(60)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfCustomModuleContents>(entity =>
            {
                entity.HasKey(e => e.IdcustomModuleContents);

                entity.ToTable("CF_CustomModuleContents");

                entity.Property(e => e.IdcustomModuleContents).HasColumnName("IDCustomModuleContents");

                entity.Property(e => e.IdcustomModule).HasColumnName("IDCustomModule");

                entity.Property(e => e.Idfile).HasColumnName("IDFile");

                entity.Property(e => e.Idtype).HasColumnName("IDType");
            });

            modelBuilder.Entity<CfDecs>(entity =>
            {
                entity.HasKey(e => e.Iddecs);

                entity.ToTable("CF_DECS");

                entity.Property(e => e.Iddecs)
                    .HasColumnName("IDDECS")
                    .ValueGeneratedNever();

                entity.Property(e => e.DecsinstallationDate)
                    .HasColumnName("DECSInstallationDate")
                    .HasColumnType("datetime");

                entity.Property(e => e.DecsmodelNo)
                    .HasColumnName("DECSModelNo")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Decsname)
                    .HasColumnName("DECSName")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Iddecslevel)
                    .HasColumnName("IDDECSLevel")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.Iddecsmanufacturer)
                    .HasColumnName("IDDECSManufacturer")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.Idengines).HasColumnName("IDEngines");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.SerialNo)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdenginesNavigation)
                    .WithMany(p => p.CfDecs)
                    .HasForeignKey(d => d.Idengines)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CF_DECS_CF_Engines");
            });

            modelBuilder.Entity<CfEngines>(entity =>
            {
                entity.HasKey(e => e.Idengines);

                entity.ToTable("CF_Engines");

                entity.HasIndex(e => e.SerialNum)
                    .HasName("IX_SerialNum")
                    .IsUnique();

                entity.Property(e => e.Idengines)
                    .HasColumnName("IDEngines")
                    .ValueGeneratedNever();

                entity.Property(e => e.Description).IsUnicode(false);

                entity.Property(e => e.Displacement)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.EngineModel)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.EstRetrofitCost).HasColumnType("money");

                entity.Property(e => e.FamilyName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Horsepower)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Hours)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IdengineFuelType)
                    .HasColumnName("IDEngineFuelType")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdengineManufacturer)
                    .HasColumnName("IDEngineManufacturer")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdengineStatus)
                    .HasColumnName("IDEngineStatus")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdmodelYear)
                    .HasColumnName("IDModelYear")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.Miles)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.SerialNum)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.SeriesModelNo)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdvehiclesNavigation)
                    .WithMany(p => p.CfEngines)
                    .HasForeignKey(d => d.Idvehicles)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CF_Engines_CF_Vehicles");
            });

            modelBuilder.Entity<CfFiles>(entity =>
            {
                entity.HasKey(e => e.Idfile);

                entity.ToTable("CF_Files");

                entity.Property(e => e.Idfile)
                    .HasColumnName("IDFile")
                    .ValueGeneratedNever();

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.FileName)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.FilePath)
                    .HasMaxLength(500)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('~/includes/filemanager/files/')");

                entity.Property(e => e.FileSize)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Iddecs).HasColumnName("IDDECS");

                entity.Property(e => e.IddocumentType).HasColumnName("IDDocumentType");

                entity.Property(e => e.Idengines).HasColumnName("IDEngines");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.IdprofileFleet).HasColumnName("IDProfileFleet");

                entity.Property(e => e.IdprofileTerminal).HasColumnName("IDProfileTerminal");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.Title)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfImages>(entity =>
            {
                entity.HasKey(e => e.Idimages);

                entity.ToTable("CF_Images");

                entity.Property(e => e.Idimages)
                    .HasColumnName("IDImages")
                    .ValueGeneratedNever();

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.FileName).IsUnicode(false);

                entity.Property(e => e.FilePath)
                    .HasMaxLength(200)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('~/includes/imagemanager/imagefiles')");

                entity.Property(e => e.Iddecs).HasColumnName("IDDECS");

                entity.Property(e => e.Idengines).HasColumnName("IDEngines");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Title)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserId).HasColumnName("UserID");
            });

            modelBuilder.Entity<CfMenuConsole>(entity =>
            {
                entity.HasKey(e => e.DataFieldId);

                entity.ToTable("CF_Menu_Console");

                entity.Property(e => e.DataFieldId).HasColumnName("DataFieldID");

                entity.Property(e => e.DataFieldParentId).HasColumnName("DataFieldParentID");

                entity.Property(e => e.DataNavigateUrlField)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.DataTextField)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ImageUrl)
                    .HasColumnName("ImageURL")
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfOptionList>(entity =>
            {
                entity.HasKey(e => e.IdoptionList);

                entity.ToTable("CF_Option_List");

                entity.Property(e => e.IdoptionList).HasColumnName("IDOptionList");

                entity.Property(e => e.DisplayValue)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.OptionName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.RecordValue)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfProfileAccount>(entity =>
            {
                entity.HasKey(e => e.IdprofileAccount);

                entity.ToTable("CF_Profile_Account");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.AccountName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.AccountNum)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Address1)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Address2)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ContractNum)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Country)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.County)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.DiscountUntilDate).HasColumnType("datetime");

                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Ext1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IdaccountParent).HasColumnName("IDAccountParent");

                entity.Property(e => e.Idclass78BactreplacementSchedule)
                    .HasColumnName("IDClass78BACTReplacementSchedule")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.Idcsr).HasColumnName("IDCSR");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprimaryContact).HasColumnName("IDPrimaryContact");

                entity.Property(e => e.IdsalesRep).HasColumnName("IDSalesRep");

                entity.Property(e => e.ImapdraftsFolder)
                    .HasColumnName("IMAPDraftsFolder")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.Imappassword)
                    .HasColumnName("IMAPPassword")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.Imapusername)
                    .HasColumnName("IMAPUsername")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.IsCorpHq)
                    .HasColumnName("IsCorpHQ")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MailMergeCode)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.NotesCf).HasColumnName("NotesCF");

                entity.Property(e => e.PayType)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Psipmonth)
                    .HasColumnName("PSIPMonth")
                    .HasMaxLength(9)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('None')");

                entity.Property(e => e.PsipnotificationEmail)
                    .HasColumnName("PSIPNotificationEmail")
                    .HasColumnType("char(1)")
                    .HasDefaultValueSql("('N')");

                entity.Property(e => e.ReferredBy)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Region)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.State)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.WebSite)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Zip)
                    .HasMaxLength(9)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfProfileContact>(entity =>
            {
                entity.HasKey(e => e.UserId);

                entity.ToTable("CF_Profile_Contact");

                entity.Property(e => e.UserId)
                    .HasColumnName("UserID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Address1)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Address2)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.CellPhone)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Country)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.County)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EmailMergeCode)
                    .HasColumnName("EMailMergeCode")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Ext1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.IdclientAccessLevel).HasColumnName("IDClientAccessLevel");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idpostfix).HasColumnName("IDPostfix");

                entity.Property(e => e.Idprefix).HasColumnName("IDPrefix");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.IdprofileContact)
                    .HasColumnName("IDProfileContact")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.Idtitle)
                    .HasColumnName("IDTitle")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.ImapdraftsFolder)
                    .HasColumnName("IMAPDraftsFolder")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.Imappassword)
                    .HasColumnName("IMAPPassword")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.Imapusername)
                    .HasColumnName("IMAPUsername")
                    .HasMaxLength(64)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MailMergeCode)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Mi)
                    .HasColumnName("MI")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.State)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Title)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserRole)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WebSite)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Zip)
                    .HasMaxLength(9)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfProfileFleet>(entity =>
            {
                entity.HasKey(e => e.IdprofileFleet);

                entity.ToTable("CF_Profile_Fleet");

                entity.Property(e => e.IdprofileFleet).HasColumnName("IDProfileFleet");

                entity.Property(e => e.Address1)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Address2)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Country)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.County)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Ext1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.FleetName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprimaryContact).HasColumnName("IDPrimaryContact");

                entity.Property(e => e.IdprofileTerminal).HasColumnName("IDProfileTerminal");

                entity.Property(e => e.IdruleCode)
                    .HasColumnName("IDRuleCode")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.State)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.WebSite)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Zip)
                    .HasMaxLength(9)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdprofileTerminalNavigation)
                    .WithMany(p => p.CfProfileFleet)
                    .HasForeignKey(d => d.IdprofileTerminal)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CF_Profile_Fleet_CF_Profile_Terminal");
            });

            modelBuilder.Entity<CfProfileTerminal>(entity =>
            {
                entity.HasKey(e => e.IdprofileTerminal);

                entity.ToTable("CF_Profile_Terminal");

                entity.Property(e => e.IdprofileTerminal).HasColumnName("IDProfileTerminal");

                entity.Property(e => e.Address1)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Address2)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Country)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.County)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Ext1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Ext3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Fax2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprimaryContact).HasColumnName("IDPrimaryContact");

                entity.Property(e => e.IdprofileAccount).HasColumnName("IDProfileAccount");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.State)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone1)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone2)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.Telephone3)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.TerminalName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.WebSite)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Zip)
                    .HasMaxLength(9)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdprofileAccountNavigation)
                    .WithMany(p => p.CfProfileTerminal)
                    .HasForeignKey(d => d.IdprofileAccount)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CF_Profile_Terminal_CF_Profile_Account");
            });

            modelBuilder.Entity<CfQeAccount>(entity =>
            {
                entity.HasKey(e => e.Idaccount);

                entity.ToTable("CF_QE_Account");

                entity.Property(e => e.Idaccount).HasColumnName("IDAccount");

                entity.Property(e => e.AccountName).HasMaxLength(150);
            });

            modelBuilder.Entity<CfQeEstimate>(entity =>
            {
                entity.HasKey(e => e.IdestimateEntry);

                entity.ToTable("CF_QE_Estimate");

                entity.Property(e => e.IdestimateEntry).HasColumnName("IDEstimateEntry");

                entity.Property(e => e.EstReplacementCost).HasColumnType("money");

                entity.Property(e => e.EstRetrofitCost).HasColumnType("money");

                entity.Property(e => e.IdchassisModelYear).HasColumnName("IDChassisModelYear");

                entity.Property(e => e.IdgrossVehicleWeight).HasColumnName("IDGrossVehicleWeight");

                entity.Property(e => e.Idqeaccount).HasColumnName("IDQEAccount");
            });

            modelBuilder.Entity<CfSignatures>(entity =>
            {
                entity.HasKey(e => e.Idsignature);

                entity.ToTable("CF_Signatures");

                entity.Property(e => e.Idsignature)
                    .HasColumnName("IDSignature")
                    .ValueGeneratedNever();

                entity.Property(e => e.EnterDate).HasColumnType("datetime");

                entity.Property(e => e.FilePath)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.LastName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");
            });

            modelBuilder.Entity<CfUserTerminals>(entity =>
            {
                entity.HasKey(e => e.IduserTerminals)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CF_UserTerminals");

                entity.Property(e => e.IduserTerminals).HasColumnName("IDUserTerminals");

                entity.Property(e => e.IdprofileTerminal).HasColumnName("IDProfileTerminal");

                entity.Property(e => e.PermissionLevel)
                    .IsRequired()
                    .HasColumnType("char(1)");
            });

            modelBuilder.Entity<CfVehicles>(entity =>
            {
                entity.HasKey(e => e.Idvehicles);

                entity.ToTable("CF_Vehicles");

                entity.HasIndex(e => e.ChassisVin)
                    .HasName("IX_ChassisVIN")
                    .IsUnique();

                entity.HasIndex(e => new { e.LicensePlateState, e.LicensePlateNo })
                    .HasName("IX_CLicensePlateState+CLicensePlateNo")
                    .IsUnique();

                entity.Property(e => e.Idvehicles)
                    .HasColumnName("IDVehicles")
                    .ValueGeneratedNever();

                entity.Property(e => e.ActualComplianceDate).HasColumnType("datetime");

                entity.Property(e => e.ActualHours)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ActualInServiceDate).HasColumnType("datetime");

                entity.Property(e => e.ActualMiles)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ActualRetirementDate).HasColumnType("datetime");

                entity.Property(e => e.AnnualHours)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.AnnualMiles)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.BackupStatusDate).HasColumnType("datetime");

                entity.Property(e => e.ChassisModel)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ChassisVin)
                    .IsRequired()
                    .HasColumnName("ChassisVIN")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Description).IsUnicode(false);

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.EstReplacementCost).HasColumnType("money");

                entity.Property(e => e.EstimatedInServiceDate).HasColumnType("datetime");

                entity.Property(e => e.GrossVehicleWeight)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Idcarbgroup)
                    .HasColumnName("IDCARBGroup")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdchassisMake)
                    .HasColumnName("IDChassisMake")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdchassisModelYear)
                    .HasColumnName("IDChassisModelYear")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdequipmentCategory)
                    .HasColumnName("IDEquipmentCategory")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdequipmentType)
                    .HasColumnName("IDEquipmentType")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.IdprofileFleet).HasColumnName("IDProfileFleet");

                entity.Property(e => e.IdruleCode)
                    .HasColumnName("IDRuleCode")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdspecialProvision)
                    .HasColumnName("IDSpecialProvision")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdvehicleStatus)
                    .HasColumnName("IDVehicleStatus")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdweightDefinition).HasColumnName("IDWeightDefinition");

                entity.Property(e => e.LastOpacityTestDate).HasColumnType("datetime");

                entity.Property(e => e.LicensePlateNo)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LicensePlateState).HasColumnType("char(2)");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);

                entity.Property(e => e.PlannedComplianceDate).HasColumnType("datetime");

                entity.Property(e => e.PlannedRetirementDate).HasColumnType("datetime");

                entity.Property(e => e.RetireStatusDate).HasColumnType("datetime");

                entity.Property(e => e.UnitNo)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UpdateVehicleInformation).HasColumnType("char(1)");

                entity.HasOne(d => d.IdprofileFleetNavigation)
                    .WithMany(p => p.CfVehicles)
                    .HasForeignKey(d => d.IdprofileFleet)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_CF_Vehicles_CF_Profile_Fleet");
            });

            modelBuilder.Entity<CfVehiclesLogHours>(entity =>
            {
                entity.HasKey(e => e.IdhoursLog);

                entity.ToTable("CF_Vehicles_Log_Hours");

                entity.Property(e => e.IdhoursLog)
                    .HasColumnName("IDHoursLog")
                    .HasDefaultValueSql("(newid())");

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.HoursDate).HasColumnType("datetime");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);
            });

            modelBuilder.Entity<CfVehiclesLogHoursOld>(entity =>
            {
                entity.HasKey(e => e.IdhoursLog);

                entity.ToTable("CF_Vehicles_Log_Hours_old");

                entity.Property(e => e.IdhoursLog).HasColumnName("IDHoursLog");

                entity.Property(e => e.BeginHours).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.BeginHoursDate).HasColumnType("datetime");

                entity.Property(e => e.EndHours).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.EndHoursDate).HasColumnType("datetime");

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfVehiclesLogMilageOld>(entity =>
            {
                entity.HasKey(e => e.IdmilageLog);

                entity.ToTable("CF_Vehicles_Log_Milage_old");

                entity.Property(e => e.IdmilageLog).HasColumnName("IDMilageLog");

                entity.Property(e => e.BeginMilage).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.BeginMilageDate).HasColumnType("datetime");

                entity.Property(e => e.EndMilage).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.EndMilageDate).HasColumnType("datetime");

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);

                entity.Property(e => e.NotesCf)
                    .HasColumnName("NotesCF")
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CfVehiclesLogMileage>(entity =>
            {
                entity.HasKey(e => e.IdmileageLog);

                entity.ToTable("CF_Vehicles_Log_Mileage");

                entity.Property(e => e.IdmileageLog)
                    .HasColumnName("IDMileageLog")
                    .HasDefaultValueSql("(newid())");

                entity.Property(e => e.EnterDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.MileageDate).HasColumnType("datetime");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.Notes).IsUnicode(false);
            });

            modelBuilder.Entity<CfVehiclesLogOpacityTests>(entity =>
            {
                entity.HasKey(e => e.IdopacityTestsLog);

                entity.ToTable("CF_Vehicles_Log_OpacityTests");

                entity.Property(e => e.IdopacityTestsLog)
                    .HasColumnName("IDOpacityTestsLog")
                    .HasDefaultValueSql("(newid())");

                entity.Property(e => e.AverageOpacity).HasColumnType("decimal(5, 2)");

                entity.Property(e => e.EnterDate).HasColumnType("datetime");

                entity.Property(e => e.IdmodifiedUser).HasColumnName("IDModifiedUser");

                entity.Property(e => e.Idvehicles).HasColumnName("IDVehicles");

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.Property(e => e.ScannerModel)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.TestDate).HasColumnType("datetime");

                entity.Property(e => e.TestResult).HasColumnType("char(4)");

                entity.Property(e => e.TestedBy)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Config>(entity =>
            {
                entity.HasKey(e => e.Uid);

                entity.Property(e => e.Uid).HasColumnName("UID");

                entity.Property(e => e.CreationDate).HasColumnType("datetime");

                entity.Property(e => e.CreationUserName).HasColumnType("char(16)");

                entity.Property(e => e.ParameterCode)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ParameterValue)
                    .HasMaxLength(500)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ConfigDsc>(entity =>
            {
                entity.HasKey(e => e.Uid);

                entity.Property(e => e.Uid).HasColumnName("UID");

                entity.Property(e => e.ParameterCode)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.ParameterDescription)
                    .HasMaxLength(60)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Counter>(entity =>
            {
                entity.ToTable("Counter", "HangFire");

                entity.HasIndex(e => new { e.Value, e.Key })
                    .HasName("IX_HangFire_Counter_Key");

                entity.Property(e => e.ExpireAt).HasColumnType("datetime");

                entity.Property(e => e.Key)
                    .IsRequired()
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<Hash>(entity =>
            {
                entity.ToTable("Hash", "HangFire");

                entity.HasIndex(e => new { e.ExpireAt, e.Key })
                    .HasName("IX_HangFire_Hash_Key");

                entity.HasIndex(e => new { e.Id, e.ExpireAt })
                    .HasName("IX_HangFire_Hash_ExpireAt");

                entity.HasIndex(e => new { e.Key, e.Field })
                    .HasName("UX_HangFire_Hash_Key_Field")
                    .IsUnique();

                entity.Property(e => e.Field)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Key)
                    .IsRequired()
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<Job>(entity =>
            {
                entity.ToTable("Job", "HangFire");

                entity.HasIndex(e => e.StateName)
                    .HasName("IX_HangFire_Job_StateName");

                entity.HasIndex(e => new { e.Id, e.ExpireAt })
                    .HasName("IX_HangFire_Job_ExpireAt");

                entity.Property(e => e.Arguments).IsRequired();

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.ExpireAt).HasColumnType("datetime");

                entity.Property(e => e.InvocationData).IsRequired();

                entity.Property(e => e.StateName).HasMaxLength(20);
            });

            modelBuilder.Entity<JobParameter>(entity =>
            {
                entity.ToTable("JobParameter", "HangFire");

                entity.HasIndex(e => new { e.JobId, e.Name })
                    .HasName("IX_HangFire_JobParameter_JobIdAndName");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(40);

                entity.HasOne(d => d.Job)
                    .WithMany(p => p.JobParameter)
                    .HasForeignKey(d => d.JobId)
                    .HasConstraintName("FK_HangFire_JobParameter_Job");
            });

            modelBuilder.Entity<JobQueue>(entity =>
            {
                entity.ToTable("JobQueue", "HangFire");

                entity.HasIndex(e => new { e.Queue, e.FetchedAt })
                    .HasName("IX_HangFire_JobQueue_QueueAndFetchedAt");

                entity.Property(e => e.FetchedAt).HasColumnType("datetime");

                entity.Property(e => e.Queue)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<List>(entity =>
            {
                entity.ToTable("List", "HangFire");

                entity.HasIndex(e => new { e.Id, e.ExpireAt })
                    .HasName("IX_HangFire_List_ExpireAt");

                entity.HasIndex(e => new { e.ExpireAt, e.Value, e.Key })
                    .HasName("IX_HangFire_List_Key");

                entity.Property(e => e.ExpireAt).HasColumnType("datetime");

                entity.Property(e => e.Key)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Value).HasColumnType("nvarchar(max)");
            });

            modelBuilder.Entity<Schema>(entity =>
            {
                entity.HasKey(e => e.Version);

                entity.ToTable("Schema", "HangFire");

                entity.Property(e => e.Version).ValueGeneratedNever();
            });

            modelBuilder.Entity<Server>(entity =>
            {
                entity.ToTable("Server", "HangFire");

                entity.Property(e => e.Id)
                    .HasMaxLength(100)
                    .ValueGeneratedNever();

                entity.Property(e => e.LastHeartbeat).HasColumnType("datetime");
            });

            modelBuilder.Entity<Set>(entity =>
            {
                entity.ToTable("Set", "HangFire");

                entity.HasIndex(e => new { e.Id, e.ExpireAt })
                    .HasName("IX_HangFire_Set_ExpireAt");

                entity.HasIndex(e => new { e.Key, e.Value })
                    .HasName("UX_HangFire_Set_KeyAndValue")
                    .IsUnique();

                entity.HasIndex(e => new { e.ExpireAt, e.Value, e.Key })
                    .HasName("IX_HangFire_Set_Key");

                entity.Property(e => e.ExpireAt).HasColumnType("datetime");

                entity.Property(e => e.Key)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Value)
                    .IsRequired()
                    .HasMaxLength(256);
            });

            modelBuilder.Entity<State>(entity =>
            {
                entity.ToTable("State", "HangFire");

                entity.HasIndex(e => e.JobId)
                    .HasName("IX_HangFire_State_JobId");

                entity.Property(e => e.CreatedAt).HasColumnType("datetime");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(20);

                entity.Property(e => e.Reason).HasMaxLength(100);

                entity.HasOne(d => d.Job)
                    .WithMany(p => p.State)
                    .HasForeignKey(d => d.JobId)
                    .HasConstraintName("FK_HangFire_State_Job");
            });
        }
    }
}

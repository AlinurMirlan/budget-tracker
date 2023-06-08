IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [AccountBalance] money NOT NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(max) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [Budgets] (
        [Id] int NOT NULL IDENTITY,
        [CategoryId] int NOT NULL,
        [Amount] money NOT NULL,
        [Date] datetime2 NOT NULL,
        CONSTRAINT [PK_Budgets] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [EntryTypes] (
        [Id] int NOT NULL IDENTITY,
        [Type] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_EntryTypes] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(450) NOT NULL,
        [ProviderKey] nvarchar(450) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(450) NOT NULL,
        [Name] nvarchar(450) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [Categories] (
        [Id] int NOT NULL IDENTITY,
        [CategoryName] nvarchar(450) NOT NULL,
        [EntryTypeId] int NOT NULL,
        [UserId] nvarchar(450) NOT NULL,
        [BudgetId] int NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Categories_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Categories_Budgets_BudgetId] FOREIGN KEY ([BudgetId]) REFERENCES [Budgets] ([Id]),
        CONSTRAINT [FK_Categories_EntryTypes_EntryTypeId] FOREIGN KEY ([EntryTypeId]) REFERENCES [EntryTypes] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [Tags] (
        [Id] int NOT NULL IDENTITY,
        [TagName] nvarchar(450) NOT NULL,
        [EntryTypeId] int NOT NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_Tags] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Tags_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Tags_EntryTypes_EntryTypeId] FOREIGN KEY ([EntryTypeId]) REFERENCES [EntryTypes] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [EntriesRecurring] (
        [Id] int NOT NULL IDENTITY,
        [CategoryId] int NOT NULL,
        [StartDate] datetime2 NOT NULL,
        [EndDate] datetime2 NOT NULL,
        [Amount] money NOT NULL,
        [Description] nvarchar(max) NULL,
        [RecurringInterval] int NOT NULL,
        CONSTRAINT [PK_EntriesRecurring] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_EntriesRecurring_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [Entries] (
        [Id] int NOT NULL IDENTITY,
        [CategoryId] int NOT NULL,
        [Date] datetime2 NOT NULL,
        [Amount] money NOT NULL,
        [TotalAmount] money NOT NULL,
        [Description] nvarchar(max) NULL,
        [EntryRecurringId] int NULL,
        [BudgetId] int NULL,
        CONSTRAINT [PK_Entries] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Entries_Budgets_BudgetId] FOREIGN KEY ([BudgetId]) REFERENCES [Budgets] ([Id]),
        CONSTRAINT [FK_Entries_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Entries_EntriesRecurring_EntryRecurringId] FOREIGN KEY ([EntryRecurringId]) REFERENCES [EntriesRecurring] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [EntryRecurringTag] (
        [EntriesRecurringId] int NOT NULL,
        [TagsId] int NOT NULL,
        CONSTRAINT [PK_EntryRecurringTag] PRIMARY KEY ([EntriesRecurringId], [TagsId]),
        CONSTRAINT [FK_EntryRecurringTag_EntriesRecurring_EntriesRecurringId] FOREIGN KEY ([EntriesRecurringId]) REFERENCES [EntriesRecurring] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_EntryRecurringTag_Tags_TagsId] FOREIGN KEY ([TagsId]) REFERENCES [Tags] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE TABLE [EntryTag] (
        [EntriesId] int NOT NULL,
        [TagsId] int NOT NULL,
        CONSTRAINT [PK_EntryTag] PRIMARY KEY ([EntriesId], [TagsId]),
        CONSTRAINT [FK_EntryTag_Entries_EntriesId] FOREIGN KEY ([EntriesId]) REFERENCES [Entries] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_EntryTag_Tags_TagsId] FOREIGN KEY ([TagsId]) REFERENCES [Tags] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Categories_BudgetId] ON [Categories] ([BudgetId]) WHERE [BudgetId] IS NOT NULL');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Categories_CategoryName] ON [Categories] ([CategoryName]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Categories_EntryTypeId] ON [Categories] ([EntryTypeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Categories_UserId] ON [Categories] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Entries_BudgetId] ON [Entries] ([BudgetId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Entries_CategoryId] ON [Entries] ([CategoryId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Entries_EntryRecurringId] ON [Entries] ([EntryRecurringId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_EntriesRecurring_CategoryId] ON [EntriesRecurring] ([CategoryId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_EntryRecurringTag_TagsId] ON [EntryRecurringTag] ([TagsId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_EntryTag_TagsId] ON [EntryTag] ([TagsId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Tags_EntryTypeId] ON [Tags] ([EntryTypeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Tags_TagName] ON [Tags] ([TagName]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    CREATE INDEX [IX_Tags_UserId] ON [Tags] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230604054800_InitialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230604054800_InitialCreate', N'7.0.5');
END;
GO

COMMIT;
GO


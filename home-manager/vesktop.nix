{ pkgs, config, ... }: {
  programs.vesktop = {
    enable = true;
    settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      useQuickCss = true;
      themeLinks = [ ];
      eagerPatches = false;
      enabledThemes = [ ];
      enableReactDevtools = false;
      frameless = false;
      transparent = false;
      winCtrlQ = false;
      disableMinSize = false;
      winNativeTitleBar = false;
      plugins = {
        ChatInputButtonAPI = {
          enabled = true;
        };
        CommandsAPI = {
          enabled = true;
        };
        DynamicImageModalAPI = {
          enabled = false;
        };
        MemberListDecoratorsAPI = {
          enabled = true;
        };
        MessageAccessoriesAPI = {
          enabled = true;
        };
        MessageDecorationsAPI = {
          enabled = true;
        };
        MessageEventsAPI = {
          enabled = true;
        };
        MessagePopoverAPI = {
          enabled = true;
        };
        MessageUpdaterAPI = {
          enabled = true;
        };
        ServerListAPI = {
          enabled = true;
        };
        UserSettingsAPI = {
          enabled = true;
        };
        AccountPanelServerProfile = {
          enabled = true;
        };
        AlwaysAnimate = {
          enabled = false;
        };
        AlwaysExpandRoles = {
          enabled = true;
        };
        AlwaysTrust = {
          enabled = true;
        };
        AnonymiseFileNames = {
          enabled = true;
        };
        AppleMusicRichPresence = {
          enabled = false;
        };
        "WebRichPresence (arRPC)" = {
          enabled = false;
        };
        BetterFolders = {
          enabled = false;
        };
        BetterGifAltText = {
          enabled = true;
        };
        BetterGifPicker = {
          enabled = false;
        };
        BetterNotesBox = {
          enabled = false;
        };
        BetterRoleContext = {
          enabled = true;
        };
        BetterRoleDot = {
          enabled = true;
        };
        BetterSessions = {
          enabled = true;
        };
        BetterSettings = {
          enabled = false;
        };
        BetterUploadButton = {
          enabled = true;
        };
        BiggerStreamPreview = {
          enabled = false;
        };
        BlurNSFW = {
          enabled = true;
        };
        CallTimer = {
          enabled = false;
        };
        CharacterCounter = {
          enabled = false;
        };
        ClearURLs = {
          enabled = true;
        };
        ClientTheme = {
          enabled = false;
        };
        ColorSighted = {
          enabled = true;
        };
        ConsoleJanitor = {
          enabled = true;
        };
        ConsoleShortcuts = {
          enabled = true;
        };
        CopyEmojiMarkdown = {
          enabled = true;
        };
        CopyFileContents = {
          enabled = false;
        };
        CopyStickerLinks = {
          enabled = true;
        };
        CopyUserURLs = {
          enabled = false;
        };
        CrashHandler = {
          enabled = true;
        };
        CustomCommands = {
          enabled = false;
        };
        CustomIdle = {
          enabled = false;
        };
        CustomRPC = {
          enabled = false;
        };
        Dearrow = {
          enabled = false;
        };
        Decor = {
          enabled = true;
        };
        DisableCallIdle = {
          enabled = true;
        };
        DontRoundMyTimestamps = {
          enabled = false;
        };
        Experiments = {
          enabled = true;
        };
        ExpressionCloner = {
          enabled = true;
        };
        F8Break = {
          enabled = false;
        };
        FakeNitro = {
          enabled = true;
          enableEmojiBypass = true;
          emojiSize = 48;
          transformEmojis = true;
          enableStickerBypass = true;
          stickerSize = 160;
          transformStickers = true;
          transformCompoundSentence = false;
          enableStreamQualityBypass = true;
          useHyperLinks = true;
          hyperLinkText = "this-is-supposed-to-be-an-emoji-but-i-dont-have-embed-perms-oh-well-heres-the-emojiname-{{NAME}}";
          disableEmbedPermissionCheck = false;
        };
        FakeProfileThemes = {
          enabled = false;
        };
        FavoriteEmojiFirst = {
          enabled = true;
        };
        FavoriteGifSearch = {
          enabled = true;
        };
        FixCodeblockGap = {
          enabled = false;
        };
        FixImagesQuality = {
          enabled = true;
        };
        FixSpotifyEmbeds = {
          enabled = true;
        };
        FixYoutubeEmbeds = {
          enabled = false;
        };
        ForceOwnerCrown = {
          enabled = true;
        };
        FriendInvites = {
          enabled = true;
        };
        FriendsSince = {
          enabled = true;
        };
        FullSearchContext = {
          enabled = true;
        };
        FullUserInChatbox = {
          enabled = true;
        };
        GameActivityToggle = {
          enabled = true;
          oldIcon = false;
        };
        GifPaste = {
          enabled = true;
        };
        GreetStickerPicker = {
          enabled = false;
        };
        HideMedia = {
          enabled = true;
        };
        iLoveSpam = {
          enabled = true;
        };
        IgnoreActivities = {
          enabled = false;
        };
        ImageFilename = {
          enabled = true;
        };
        ImageLink = {
          enabled = true;
        };
        ImageZoom = {
          enabled = true;
        };
        ImplicitRelationships = {
          enabled = false;
          sortByAffinity = true;
        };
        IrcColors = {
          enabled = false;
        };
        KeepCurrentChannel = {
          enabled = false;
        };
        LastFMRichPresence = {
          enabled = false;
        };
        LoadingQuotes = {
          enabled = false;
        };
        MemberCount = {
          enabled = true;
        };
        MentionAvatars = {
          enabled = true;
        };
        MessageClickActions = {
          enabled = true;
        };
        MessageLatency = {
          enabled = true;
        };
        MessageLinkEmbeds = {
          enabled = false;
        };
        MessageLogger = {
          enabled = true;
        };
        MoreQuickReactions = {
          enabled = true;
          reactionCount = 5;
        };
        MutualGroupDMs = {
          enabled = false;
        };
        NewGuildSettings = {
          enabled = false;
        };
        NoBlockedMessages = {
          enabled = false;
        };
        NoDevtoolsWarning = {
          enabled = true;
        };
        NoF1 = {
          enabled = false;
        };
        NoMaskedUrlPaste = {
          enabled = true;
        };
        NoMosaic = {
          enabled = false;
        };
        NoOnboardingDelay = {
          enabled = true;
        };
        NoPendingCount = {
          enabled = false;
        };
        NoProfileThemes = {
          enabled = true;
        };
        NoReplyMention = {
          enabled = false;
        };
        NoServerEmojis = {
          enabled = false;
        };
        NoTypingAnimation = {
          enabled = true;
        };
        NoUnblockToJump = {
          enabled = true;
        };
        NotificationVolume = {
          enabled = false;
        };
        OnePingPerDM = {
          enabled = false;
        };
        oneko = {
          enabled = false;
        };
        OpenInApp = {
          enabled = true;
        };
        OverrideForumDefaults = {
          enabled = false;
        };
        PauseInvitesForever = {
          enabled = true;
        };
        PermissionFreeWill = {
          enabled = true;
        };
        PermissionsViewer = {
          enabled = true;
        };
        petpet = {
          enabled = true;
        };
        PictureInPicture = {
          enabled = false;
        };
        PinDMs = {
          enabled = false;
        };
        PlainFolderIcon = {
          enabled = false;
        };
        PlatformIndicators = {
          enabled = true;
          list = true;
          badges = true;
          messages = false;
          colorMobileIndicator = true;
        };
        PreviewMessage = {
          enabled = true;
        };
        QuickMention = {
          enabled = true;
        };
        QuickReply = {
          enabled = false;
        };
        ReactErrorDecoder = {
          enabled = true;
        };
        ReadAllNotificationsButton = {
          enabled = true;
        };
        RelationshipNotifier = {
          enabled = true;
        };
        ReplaceGoogleSearch = {
          enabled = true;
          replacementEngine = "custom";
          customEngineURL = "https://duckduckgo.com/?q=";
          customEngineName = "DuckDuckGo";
        };
        ReplyTimestamp = {
          enabled = false;
        };
        RevealAllSpoilers = {
          enabled = true;
        };
        ReverseImageSearch = {
          enabled = false;
        };
        ReviewDB = {
          enabled = true;
        };
        RoleColorEverywhere = {
          enabled = false;
        };
        SecretRingToneEnabler = {
          enabled = false;
        };
        Summaries = {
          enabled = false;
        };
        SendTimestamps = {
          enabled = false;
        };
        ServerInfo = {
          enabled = false;
        };
        ServerListIndicators = {
          enabled = false;
        };
        ShikiCodeblocks = {
          enabled = false;
        };
        ShowAllMessageButtons = {
          enabled = false;
        };
        ShowConnections = {
          enabled = true;
        };
        ShowHiddenChannels = {
          enabled = true;
        };
        ShowHiddenThings = {
          enabled = true;
        };
        ShowMeYourName = {
          enabled = true;
          mode = "nick-user";
          friendNicknames = "dms";
          displayNames = false;
          inReplies = false;
        };
        ShowTimeoutDuration = {
          enabled = false;
        };
        SilentMessageToggle = {
          enabled = false;
        };
        SilentTyping = {
          enabled = false;
        };
        SortFriendRequests = {
          enabled = true;
          showDates = true;
        };
        SpotifyControls = {
          enabled = false;
        };
        SpotifyCrack = {
          enabled = true;
        };
        SpotifyShareCommands = {
          enabled = false;
        };
        StartupTimings = {
          enabled = false;
        };
        StickerPaste = {
          enabled = false;
        };
        StreamerModeOnStream = {
          enabled = false;
        };
        SuperReactionTweaks = {
          enabled = true;
          superReactByDefault = false;
          unlimitedSuperReactionPlaying = false;
          superReactionPlayingLimit = 0;
        };
        TextReplace = {
          enabled = false;
        };
        ThemeAttributes = {
          enabled = false;
        };
        Translate = {
          enabled = false;
        };
        TypingIndicator = {
          enabled = true;
        };
        TypingTweaks = {
          enabled = true;
        };
        Unindent = {
          enabled = false;
        };
        UnlockedAvatarZoom = {
          enabled = false;
        };
        UnsuppressEmbeds = {
          enabled = false;
        };
        UserMessagesPronouns = {
          enabled = true;
          pronounsFormat = "LOWERCASE";
          showSelf = true;
        };
        UserVoiceShow = {
          enabled = false;
        };
        USRBG = {
          enabled = false;
        };
        ValidReply = {
          enabled = true;
        };
        ValidUser = {
          enabled = true;
        };
        VoiceChatDoubleClick = {
          enabled = true;
        };
        VcNarrator = {
          enabled = false;
        };
        VencordToolbox = {
          enabled = true;
        };
        ViewIcons = {
          enabled = false;
        };
        ViewRaw = {
          enabled = true;
        };
        VoiceDownload = {
          enabled = false;
        };
        VoiceMessages = {
          enabled = false;
        };
        VolumeBooster = {
          enabled = true;
        };
        WebKeybinds = {
          enabled = true;
        };
        WebScreenShareFixes = {
          enabled = true;
        };
        WhoReacted = {
          enabled = true;
        };
        XSOverlay = {
          enabled = false;
        };
        YoutubeAdblock = {
          enabled = false;
        };
        BadgeAPI = {
          enabled = true;
        };
        NoTrack = {
          enabled = true;
          disableAnalytics = true;
        };
        Settings = {
          enabled = true;
          settingsLocation = "aboveNitro";
        };
        ConcatenatedComponentExtractor = {
          enabled = true;
        };
        DisableDeepLinks = {
          enabled = true;
        };
        SupportHelper = {
          enabled = true;
        };
        WebContextMenus = {
          enabled = true;
        };
      };
      uiElements = {
        chatBarButtons = { };
        messagePopoverButtons = { };
      };
      notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };
      cloud = {
        authenticated = false;
        url = "https://api.vencord.dev/";
        settingsSync = false;
        settingsSyncVersion = 1777506145180;
      };
    };
  };
}

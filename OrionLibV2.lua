local OrionLibV2 = {}
         local Icons = {
			["accessibility"] = "rbxassetid://10709751939",
			["activity"] = "rbxassetid://10709752035",
			["airvent"] = "rbxassetid://10709752131",
			["airplay"] = "rbxassetid://10709752254",
			["alarmcheck"] = "rbxassetid://10709752405",
			["alarmclock"] = "rbxassetid://10709752630",
			["alarmclockoff"] = "rbxassetid://10709752508",
			["alarmminus"] = "rbxassetid://10709752732",
			["alarmplus"] = "rbxassetid://10709752825",
			["album"] = "rbxassetid://10709752906",
			["alertcircle"] = "rbxassetid://10709752996",
			["alertoctagon"] = "rbxassetid://10709753064",
			["alerttriangle"] = "rbxassetid://10709753149",
			["aligncenter"] = "rbxassetid://10709753570",
			["aligncenterhorizontal"] = "rbxassetid://10709753272",
			["aligncentervertical"] = "rbxassetid://10709753421",
			["alignendhorizontal"] = "rbxassetid://10709753692",
			["alignendvertical"] = "rbxassetid://10709753808",
			["alignhorizontaldistributecenter"] = "rbxassetid://10747779791",
			["alignhorizontaldistributeend"] = "rbxassetid://10747784534",
			["alignhorizontaldistributestart"] = "rbxassetid://10709754118",
			["alignhorizontaljustifycenter"] = "rbxassetid://10709754204",
			["alignhorizontaljustifyend"] = "rbxassetid://10709754317",
			["alignhorizontaljustifystart"] = "rbxassetid://10709754436",
			["alignhorizontalspacearound"] = "rbxassetid://10709754590",
			["alignhorizontalspacebetween"] = "rbxassetid://10709754749",
			["alignjustify"] = "rbxassetid://10709759610",
			["alignleft"] = "rbxassetid://10709759764",
			["alignright"] = "rbxassetid://10709759895",
			["alignstarthorizontal"] = "rbxassetid://10709760051",
			["alignstartvertical"] = "rbxassetid://10709760244",
			["alignverticaldistributecenter"] = "rbxassetid://10709760351",
			["alignverticaldistributeend"] = "rbxassetid://10709760434",
			["alignverticaldistributestart"] = "rbxassetid://10709760612",
			["alignverticaljustifycenter"] = "rbxassetid://10709760814",
			["alignverticaljustifyend"] = "rbxassetid://10709761003",
			["alignverticaljustifystart"] = "rbxassetid://10709761176",
			["alignverticalspacearound"] = "rbxassetid://10709761324",
			["alignverticalspacebetween"] = "rbxassetid://10709761434",
			["anchor"] = "rbxassetid://10709761530",
			["angry"] = "rbxassetid://10709761629",
			["annoyed"] = "rbxassetid://10709761722",
			["aperture"] = "rbxassetid://10709761813",
			["apple"] = "rbxassetid://10709761889",
			["archive"] = "rbxassetid://10709762233",
			["archiverestore"] = "rbxassetid://10709762058",
			["armchair"] = "rbxassetid://10709762327",
			["arrowbigdown"] = "rbxassetid://10747796644",
			["arrowbigleft"] = "rbxassetid://10709762574",
			["arrowbigright"] = "rbxassetid://10709762727",
			["arrowbigup"] = "rbxassetid://10709762879",
			["arrowdown"] = "rbxassetid://10709767827",
			["arrowdowncircle"] = "rbxassetid://10709763034",
			["arrowdownleft"] = "rbxassetid://10709767656",
			["arrowdownright"] = "rbxassetid://10709767750",
			["arrowleft"] = "rbxassetid://10709768114",
			["arrowleftcircle"] = "rbxassetid://10709767936",
			["arrowleftright"] = "rbxassetid://10709768019",
			["arrowright"] = "rbxassetid://10709768347",
			["arrowrightcircle"] = "rbxassetid://10709768226",
			["arrowup"] = "rbxassetid://10709768939",
			["arrowupcircle"] = "rbxassetid://10709768432",
			["arrowupdown"] = "rbxassetid://10709768538",
			["arrowupleft"] = "rbxassetid://10709768661",
			["arrowupright"] = "rbxassetid://10709768787",
			["asterisk"] = "rbxassetid://10709769095",
			["atsign"] = "rbxassetid://10709769286",
			["award"] = "rbxassetid://10709769406",
			["axe"] = "rbxassetid://10709769508",
			["axis3d"] = "rbxassetid://10709769598",
			["baby"] = "rbxassetid://10709769732",
			["backpack"] = "rbxassetid://10709769841",
			["baggageclaim"] = "rbxassetid://10709769935",
			["banana"] = "rbxassetid://10709770005",
			["banknote"] = "rbxassetid://10709770178",
			["barchart"] = "rbxassetid://10709773755",
			["barchart2"] = "rbxassetid://10709770317",
			["barchart3"] = "rbxassetid://10709770431",
			["barchart4"] = "rbxassetid://10709770560",
			["barcharthorizontal"] = "rbxassetid://10709773669",
			["barcode"] = "rbxassetid://10747360675",
			["baseline"] = "rbxassetid://10709773863",
			["bath"] = "rbxassetid://10709773963",
			["battery"] = "rbxassetid://10709774640",
			["batterycharging"] = "rbxassetid://10709774068",
			["batteryfull"] = "rbxassetid://10709774206",
			["batterylow"] = "rbxassetid://10709774370",
			["batterymedium"] = "rbxassetid://10709774513",
			["beaker"] = "rbxassetid://10709774756",
			["bed"] = "rbxassetid://10709775036",
			["beddouble"] = "rbxassetid://10709774864",
			["bedsingle"] = "rbxassetid://10709774968",
			["beer"] = "rbxassetid://10709775167",
			["bell"] = "rbxassetid://10709775704",
			["bellminus"] = "rbxassetid://10709775241",
			["belloff"] = "rbxassetid://10709775320",
			["bellplus"] = "rbxassetid://10709775448",
			["bellring"] = "rbxassetid://10709775560",
			["bike"] = "rbxassetid://10709775894",
			["binary"] = "rbxassetid://10709776050",
			["bitcoin"] = "rbxassetid://10709776126",
			["bluetooth"] = "rbxassetid://10709776655",
			["bluetoothconnected"] = "rbxassetid://10709776240",
			["bluetoothoff"] = "rbxassetid://10709776344",
			["bluetoothsearching"] = "rbxassetid://10709776501",
			["bold"] = "rbxassetid://10747813908",
			["bomb"] = "rbxassetid://10709781460",
			["bone"] = "rbxassetid://10709781605",
			["book"] = "rbxassetid://10709781824",
			["bookopen"] = "rbxassetid://10709781717",
			["bookmark"] = "rbxassetid://10709782154",
			["bookmarkminus"] = "rbxassetid://10709781919",
			["bookmarkplus"] = "rbxassetid://10709782044",
			["bot"] = "rbxassetid://10709782230",
			["box"] = "rbxassetid://10709782497",
			["boxselect"] = "rbxassetid://10709782342",
			["boxes"] = "rbxassetid://10709782582",
			["briefcase"] = "rbxassetid://10709782662",
			["brush"] = "rbxassetid://10709782758",
			["bug"] = "rbxassetid://10709782845",
			["building"] = "rbxassetid://10709783051",
			["building2"] = "rbxassetid://10709782939",
			["bus"] = "rbxassetid://10709783137",
			["cake"] = "rbxassetid://10709783217",
			["calculator"] = "rbxassetid://10709783311",
			["calendar"] = "rbxassetid://10709789505",
			["calendarcheck"] = "rbxassetid://10709783474",
			["calendarcheck2"] = "rbxassetid://10709783392",
			["calendarclock"] = "rbxassetid://10709783577",
			["calendardays"] = "rbxassetid://10709783673",
			["calendarheart"] = "rbxassetid://10709783835",
			["calendarminus"] = "rbxassetid://10709783959",
			["calendaroff"] = "rbxassetid://10709788784",
			["calendarplus"] = "rbxassetid://10709788937",
			["calendarrange"] = "rbxassetid://10709789053",
			["calendarsearch"] = "rbxassetid://10709789200",
			["calendarx"] = "rbxassetid://10709789407",
			["calendarx2"] = "rbxassetid://10709789329",
			["camera"] = "rbxassetid://10709789686",
			["cameraoff"] = "rbxassetid://10747822677",
			["car"] = "rbxassetid://10709789810",
			["carrot"] = "rbxassetid://10709789960",
			["cast"] = "rbxassetid://10709790097",
			["charge"] = "rbxassetid://10709790202",
			["check"] = "rbxassetid://10709790644",
			["checkcircle"] = "rbxassetid://10709790387",
			["checkcircle2"] = "rbxassetid://10709790298",
			["checksquare"] = "rbxassetid://10709790537",
			["chefhat"] = "rbxassetid://10709790757",
			["cherry"] = "rbxassetid://10709790875",
			["chevrondown"] = "rbxassetid://10709790948",
			["chevronfirst"] = "rbxassetid://10709791015",
			["chevronlast"] = "rbxassetid://10709791130",
			["chevronleft"] = "rbxassetid://10709791281",
			["chevronright"] = "rbxassetid://10709791437",
			["chevronup"] = "rbxassetid://10709791523",
			["chevronsdown"] = "rbxassetid://10709796864",
			["chevronsdownup"] = "rbxassetid://10709791632",
			["chevronsleft"] = "rbxassetid://10709797151",
			["chevronsleftright"] = "rbxassetid://10709797006",
			["chevronsright"] = "rbxassetid://10709797382",
			["chevronsrightleft"] = "rbxassetid://10709797274",
			["chevronsup"] = "rbxassetid://10709797622",
			["chevronsupdown"] = "rbxassetid://10709797508",
			["chrome"] = "rbxassetid://10709797725",
			["circle"] = "rbxassetid://10709798174",
			["circledot"] = "rbxassetid://10709797837",
			["circleellipsis"] = "rbxassetid://10709797985",
			["circleslashed"] = "rbxassetid://10709798100",
			["citrus"] = "rbxassetid://10709798276",
			["clapperboard"] = "rbxassetid://10709798350",
			["clipboard"] = "rbxassetid://10709799288",
			["clipboardcheck"] = "rbxassetid://10709798443",
			["clipboardcopy"] = "rbxassetid://10709798574",
			["clipboardedit"] = "rbxassetid://10709798682",
			["clipboardlist"] = "rbxassetid://10709798792",
			["clipboardsignature"] = "rbxassetid://10709798890",
			["clipboardtype"] = "rbxassetid://10709798999",
			["clipboardx"] = "rbxassetid://10709799124",
			["clock"] = "rbxassetid://10709805144",
			["clock1"] = "rbxassetid://10709799535",
			["clock10"] = "rbxassetid://10709799718",
			["clock11"] = "rbxassetid://10709799818",
			["clock12"] = "rbxassetid://10709799962",
			["clock2"] = "rbxassetid://10709803876",
			["clock3"] = "rbxassetid://10709803989",
			["clock4"] = "rbxassetid://10709804164",
			["clock5"] = "rbxassetid://10709804291",
			["clock6"] = "rbxassetid://10709804435",
			["clock7"] = "rbxassetid://10709804599",
			["clock8"] = "rbxassetid://10709804784",
			["clock9"] = "rbxassetid://10709804996",
			["cloud"] = "rbxassetid://10709806740",
			["cloudcog"] = "rbxassetid://10709805262",
			["clouddrizzle"] = "rbxassetid://10709805371",
			["cloudfog"] = "rbxassetid://10709805477",
			["cloudhail"] = "rbxassetid://10709805596",
			["cloudlightning"] = "rbxassetid://10709805727",
			["cloudmoon"] = "rbxassetid://10709805942",
			["cloudmoonrain"] = "rbxassetid://10709805838",
			["cloudoff"] = "rbxassetid://10709806060",
			["cloudrain"] = "rbxassetid://10709806277",
			["cloudrainwind"] = "rbxassetid://10709806166",
			["cloudsnow"] = "rbxassetid://10709806374",
			["cloudsun"] = "rbxassetid://10709806631",
			["cloudsunrain"] = "rbxassetid://10709806475",
			["cloudy"] = "rbxassetid://10709806859",
			["clover"] = "rbxassetid://10709806995",
			["code"] = "rbxassetid://10709810463",
			["code2"] = "rbxassetid://10709807111",
			["codepen"] = "rbxassetid://10709810534",
			["codesandbox"] = "rbxassetid://10709810676",
			["coffee"] = "rbxassetid://10709810814",
			["cog"] = "rbxassetid://10709810948",
			["coins"] = "rbxassetid://10709811110",
			["columns"] = "rbxassetid://10709811261",
			["command"] = "rbxassetid://10709811365",
			["compass"] = "rbxassetid://10709811445",
			["component"] = "rbxassetid://10709811595",
			["conciergebell"] = "rbxassetid://10709811706",
			["connection"] = "rbxassetid://10747361219",
			["contact"] = "rbxassetid://10709811834",
			["contrast"] = "rbxassetid://10709811939",
			["cookie"] = "rbxassetid://10709812067",
			["copy"] = "rbxassetid://10709812159",
			["copyleft"] = "rbxassetid://10709812251",
			["copyright"] = "rbxassetid://10709812311",
			["cornerdownleft"] = "rbxassetid://10709812396",
			["cornerdownright"] = "rbxassetid://10709812485",
			["cornerleftdown"] = "rbxassetid://10709812632",
			["cornerleftup"] = "rbxassetid://10709812784",
			["cornerrightdown"] = "rbxassetid://10709812939",
			["cornerrightup"] = "rbxassetid://10709813094",
			["cornerupleft"] = "rbxassetid://10709813185",
			["cornerupright"] = "rbxassetid://10709813281",
			["cpu"] = "rbxassetid://10709813383",
			["croissant"] = "rbxassetid://10709818125",
			["crop"] = "rbxassetid://10709818245",
			["cross"] = "rbxassetid://10709818399",
			["crosshair"] = "rbxassetid://10709818534",
			["crown"] = "rbxassetid://10709818626",
			["cupsoda"] = "rbxassetid://10709818763",
			["curlybraces"] = "rbxassetid://10709818847",
			["currency"] = "rbxassetid://10709818931",
			["database"] = "rbxassetid://10709818996",
			["delete"] = "rbxassetid://10709819059",
			["diamond"] = "rbxassetid://10709819149",
			["dice1"] = "rbxassetid://10709819266",
			["dice2"] = "rbxassetid://10709819361",
			["dice3"] = "rbxassetid://10709819508",
			["dice4"] = "rbxassetid://10709819670",
			["dice5"] = "rbxassetid://10709819801",
			["dice6"] = "rbxassetid://10709819896",
			["dices"] = "rbxassetid://10723343321",
			["diff"] = "rbxassetid://10723343416",
			["disc"] = "rbxassetid://10723343537",
			["divide"] = "rbxassetid://10723343805",
			["dividecircle"] = "rbxassetid://10723343636",
			["dividesquare"] = "rbxassetid://10723343737",
			["dollarsign"] = "rbxassetid://10723343958",
			["download"] = "rbxassetid://10723344270",
			["downloadcloud"] = "rbxassetid://10723344088",
			["droplet"] = "rbxassetid://10723344432",
			["droplets"] = "rbxassetid://10734883356",
			["drumstick"] = "rbxassetid://10723344737",
			["edit"] = "rbxassetid://10734883598",
			["edit2"] = "rbxassetid://10723344885",
			["edit3"] = "rbxassetid://10723345088",
			["egg"] = "rbxassetid://10723345518",
			["eggfried"] = "rbxassetid://10723345347",
			["electricity"] = "rbxassetid://10723345749",
			["electricityoff"] = "rbxassetid://10723345643",
			["equal"] = "rbxassetid://10723345990",
			["equalnot"] = "rbxassetid://10723345866",
			["eraser"] = "rbxassetid://10723346158",
			["euro"] = "rbxassetid://10723346372",
			["expand"] = "rbxassetid://10723346553",
			["externallink"] = "rbxassetid://10723346684",
			["eye"] = "rbxassetid://10723346959",
			["eyeoff"] = "rbxassetid://10723346871",
			["factory"] = "rbxassetid://10723347051",
			["fan"] = "rbxassetid://10723354359",
			["fastforward"] = "rbxassetid://10723354521",
			["feather"] = "rbxassetid://10723354671",
			["figma"] = "rbxassetid://10723354801",
			["file"] = "rbxassetid://10723374641",
			["filearchive"] = "rbxassetid://10723354921",
			["fileaudio"] = "rbxassetid://10723355148",
			["fileaudio2"] = "rbxassetid://10723355026",
			["fileaxis3d"] = "rbxassetid://10723355272",
			["filebadge"] = "rbxassetid://10723355622",
			["filebadge2"] = "rbxassetid://10723355451",
			["filebarchart"] = "rbxassetid://10723355887",
			["filebarchart2"] = "rbxassetid://10723355746",
			["filebox"] = "rbxassetid://10723355989",
			["filecheck"] = "rbxassetid://10723356210",
			["filecheck2"] = "rbxassetid://10723356100",
			["fileclock"] = "rbxassetid://10723356329",
			["filecode"] = "rbxassetid://10723356507",
			["filecog"] = "rbxassetid://10723356830",
			["filecog2"] = "rbxassetid://10723356676",
			["filediff"] = "rbxassetid://10723357039",
			["filedigit"] = "rbxassetid://10723357151",
			["filedown"] = "rbxassetid://10723357322",
			["fileedit"] = "rbxassetid://10723357495",
			["fileheart"] = "rbxassetid://10723357637",
			["fileimage"] = "rbxassetid://10723357790",
			["fileinput"] = "rbxassetid://10723357933",
			["filejson"] = "rbxassetid://10723364435",
			["filejson2"] = "rbxassetid://10723364361",
			["filekey"] = "rbxassetid://10723364605",
			["filekey2"] = "rbxassetid://10723364515",
			["filelinechart"] = "rbxassetid://10723364725",
			["filelock"] = "rbxassetid://10723364957",
			["filelock2"] = "rbxassetid://10723364861",
			["fileminus"] = "rbxassetid://10723365254",
			["fileminus2"] = "rbxassetid://10723365086",
			["fileoutput"] = "rbxassetid://10723365457",
			["filepiechart"] = "rbxassetid://10723365598",
			["fileplus"] = "rbxassetid://10723365877",
			["fileplus2"] = "rbxassetid://10723365766",
			["filequestion"] = "rbxassetid://10723365987",
			["filescan"] = "rbxassetid://10723366167",
			["filesearch"] = "rbxassetid://10723366550",
			["filesearch2"] = "rbxassetid://10723366340",
			["filesignature"] = "rbxassetid://10723366741",
			["filespreadsheet"] = "rbxassetid://10723366962",
			["filesymlink"] = "rbxassetid://10723367098",
			["fileterminal"] = "rbxassetid://10723367244",
			["filetext"] = "rbxassetid://10723367380",
			["filetype"] = "rbxassetid://10723367606",
			["filetype2"] = "rbxassetid://10723367509",
			["fileup"] = "rbxassetid://10723367734",
			["filevideo"] = "rbxassetid://10723373884",
			["filevideo2"] = "rbxassetid://10723367834",
			["filevolume"] = "rbxassetid://10723374172",
			["filevolume2"] = "rbxassetid://10723374030",
			["filewarning"] = "rbxassetid://10723374276",
			["filex"] = "rbxassetid://10723374544",
			["filex2"] = "rbxassetid://10723374378",
			["files"] = "rbxassetid://10723374759",
			["film"] = "rbxassetid://10723374981",
			["filter"] = "rbxassetid://10723375128",
			["fingerprint"] = "rbxassetid://10723375250",
			["flag"] = "rbxassetid://10723375890",
			["flagoff"] = "rbxassetid://10723375443",
			["flagtriangleleft"] = "rbxassetid://10723375608",
			["flagtriangleright"] = "rbxassetid://10723375727",
			["flame"] = "rbxassetid://10723376114",
			["flashlight"] = "rbxassetid://10723376471",
			["flashlightoff"] = "rbxassetid://10723376365",
			["flaskconical"] = "rbxassetid://10734883986",
			["flaskround"] = "rbxassetid://10723376614",
			["fliphorizontal"] = "rbxassetid://10723376884",
			["fliphorizontal2"] = "rbxassetid://10723376745",
			["flipvertical"] = "rbxassetid://10723377138",
			["flipvertical2"] = "rbxassetid://10723377026",
			["flower"] = "rbxassetid://10747830374",
			["flower2"] = "rbxassetid://10723377305",
			["focus"] = "rbxassetid://10723377537",
			["folder"] = "rbxassetid://10723387563",
			["folderarchive"] = "rbxassetid://10723384478",
			["foldercheck"] = "rbxassetid://10723384605",
			["folderclock"] = "rbxassetid://10723384731",
			["folderclosed"] = "rbxassetid://10723384893",
			["foldercog"] = "rbxassetid://10723385213",
			["foldercog2"] = "rbxassetid://10723385036",
			["folderdown"] = "rbxassetid://10723385338",
			["folderedit"] = "rbxassetid://10723385445",
			["folderheart"] = "rbxassetid://10723385545",
			["folderinput"] = "rbxassetid://10723385721",
			["folderkey"] = "rbxassetid://10723385848",
			["folderlock"] = "rbxassetid://10723386005",
			["folderminus"] = "rbxassetid://10723386127",
			["folderopen"] = "rbxassetid://10723386277",
			["folderoutput"] = "rbxassetid://10723386386",
			["folderplus"] = "rbxassetid://10723386531",
			["foldersearch"] = "rbxassetid://10723386787",
			["foldersearch2"] = "rbxassetid://10723386674",
			["foldersymlink"] = "rbxassetid://10723386930",
			["foldertree"] = "rbxassetid://10723387085",
			["folderup"] = "rbxassetid://10723387265",
			["folderx"] = "rbxassetid://10723387448",
			["folders"] = "rbxassetid://10723387721",
			["forminput"] = "rbxassetid://10723387841",
			["forward"] = "rbxassetid://10723388016",
			["frame"] = "rbxassetid://10723394389",
			["framer"] = "rbxassetid://10723394565",
			["frown"] = "rbxassetid://10723394681",
			["fuel"] = "rbxassetid://10723394846",
			["functionsquare"] = "rbxassetid://10723395041",
			["gamepad"] = "rbxassetid://10723395457",
			["gamepad2"] = "rbxassetid://10723395215",
			["gauge"] = "rbxassetid://10723395708",
			["gavel"] = "rbxassetid://10723395896",
			["gem"] = "rbxassetid://10723396000",
			["ghost"] = "rbxassetid://10723396107",
			["gift"] = "rbxassetid://10723396402",
			["giftcard"] = "rbxassetid://10723396225",
			["gitbranch"] = "rbxassetid://10723396676",
			["gitbranchplus"] = "rbxassetid://10723396542",
			["gitcommit"] = "rbxassetid://10723396812",
			["gitcompare"] = "rbxassetid://10723396954",
			["gitfork"] = "rbxassetid://10723397049",
			["gitmerge"] = "rbxassetid://10723397165",
			["gitpullrequest"] = "rbxassetid://10723397431",
			["gitpullrequestclosed"] = "rbxassetid://10723397268",
			["gitpullrequestdraft"] = "rbxassetid://10734884302",
			["glass"] = "rbxassetid://10723397788",
			["glass2"] = "rbxassetid://10723397529",
			["glasswater"] = "rbxassetid://10723397678",
			["glasses"] = "rbxassetid://10723397895",
			["globe"] = "rbxassetid://10723404337",
			["globe2"] = "rbxassetid://10723398002",
			["grab"] = "rbxassetid://10723404472",
			["graduationcap"] = "rbxassetid://10723404691",
			["grape"] = "rbxassetid://10723404822",
			["grid"] = "rbxassetid://10723404936",
			["griphorizontal"] = "rbxassetid://10723405089",
			["gripvertical"] = "rbxassetid://10723405236",
			["hammer"] = "rbxassetid://10723405360",
			["hand"] = "rbxassetid://10723405649",
			["handmetal"] = "rbxassetid://10723405508",
			["harddrive"] = "rbxassetid://10723405749",
			["hardhat"] = "rbxassetid://10723405859",
			["hash"] = "rbxassetid://10723405975",
			["haze"] = "rbxassetid://10723406078",
			["headphones"] = "rbxassetid://10723406165",
			["heart"] = "rbxassetid://10723406885",
			["heartcrack"] = "rbxassetid://10723406299",
			["hearthandshake"] = "rbxassetid://10723406480",
			["heartoff"] = "rbxassetid://10723406662",
			["heartpulse"] = "rbxassetid://10723406795",
			["helpcircle"] = "rbxassetid://10723406988",
			["hexagon"] = "rbxassetid://10723407092",
			["highlighter"] = "rbxassetid://10723407192",
			["history"] = "rbxassetid://10723407335",
			["home"] = "rbxassetid://10723407389",
			["hourglass"] = "rbxassetid://10723407498",
			["icecream"] = "rbxassetid://10723414308",
			["image"] = "rbxassetid://10723415040",
			["imageminus"] = "rbxassetid://10723414487",
			["imageoff"] = "rbxassetid://10723414677",
			["imageplus"] = "rbxassetid://10723414827",
			["import"] = "rbxassetid://10723415205",
			["inbox"] = "rbxassetid://10723415335",
			["indent"] = "rbxassetid://10723415494",
			["indianrupee"] = "rbxassetid://10723415642",
			["infinity"] = "rbxassetid://10723415766",
			["info"] = "rbxassetid://10723415903",
			["inspect"] = "rbxassetid://10723416057",
			["italic"] = "rbxassetid://10723416195",
			["japaneseyen"] = "rbxassetid://10723416363",
			["joystick"] = "rbxassetid://10723416527",
			["key"] = "rbxassetid://10723416652",
			["keyboard"] = "rbxassetid://10723416765",
			["lamp"] = "rbxassetid://10723417513",
			["lampceiling"] = "rbxassetid://10723416922",
			["lampdesk"] = "rbxassetid://10723417016",
			["lampfloor"] = "rbxassetid://10723417131",
			["lampwalldown"] = "rbxassetid://10723417240",
			["lampwallup"] = "rbxassetid://10723417356",
			["landmark"] = "rbxassetid://10723417608",
			["languages"] = "rbxassetid://10723417703",
			["laptop"] = "rbxassetid://10723423881",
			["laptop2"] = "rbxassetid://10723417797",
			["lasso"] = "rbxassetid://10723424235",
			["lassoselect"] = "rbxassetid://10723424058",
			["laugh"] = "rbxassetid://10723424372",
			["layers"] = "rbxassetid://10723424505",
			["layout"] = "rbxassetid://10723425376",
			["layoutdashboard"] = "rbxassetid://10723424646",
			["layoutgrid"] = "rbxassetid://10723424838",
			["layoutlist"] = "rbxassetid://10723424963",
			["layouttemplate"] = "rbxassetid://10723425187",
			["leaf"] = "rbxassetid://10723425539",
			["library"] = "rbxassetid://10723425615",
			["lifebuoy"] = "rbxassetid://10723425685",
			["lightbulb"] = "rbxassetid://10723425852",
			["lightbulboff"] = "rbxassetid://10723425762",
			["linechart"] = "rbxassetid://10723426393",
			["link"] = "rbxassetid://10723426722",
			["link2"] = "rbxassetid://10723426595",
			["link2off"] = "rbxassetid://10723426513",
			["list"] = "rbxassetid://10723433811",
			["listchecks"] = "rbxassetid://10734884548",
			["listend"] = "rbxassetid://10723426886",
			["listminus"] = "rbxassetid://10723426986",
			["listmusic"] = "rbxassetid://10723427081",
			["listordered"] = "rbxassetid://10723427199",
			["listplus"] = "rbxassetid://10723427334",
			["liststart"] = "rbxassetid://10723427494",
			["listvideo"] = "rbxassetid://10723427619",
			["listx"] = "rbxassetid://10723433655",
			["loader"] = "rbxassetid://10723434070",
			["loader2"] = "rbxassetid://10723433935",
			["locate"] = "rbxassetid://10723434557",
			["locatefixed"] = "rbxassetid://10723434236",
			["locateoff"] = "rbxassetid://10723434379",
			["lock"] = "rbxassetid://10723434711",
			["login"] = "rbxassetid://10723434830",
			["logout"] = "rbxassetid://10723434906",
			["luggage"] = "rbxassetid://10723434993",
			["magnet"] = "rbxassetid://10723435069",
			["mail"] = "rbxassetid://10734885430",
			["mailcheck"] = "rbxassetid://10723435182",
			["mailminus"] = "rbxassetid://10723435261",
			["mailopen"] = "rbxassetid://10723435342",
			["mailplus"] = "rbxassetid://10723435443",
			["mailquestion"] = "rbxassetid://10723435515",
			["mailsearch"] = "rbxassetid://10734884739",
			["mailwarning"] = "rbxassetid://10734885015",
			["mailx"] = "rbxassetid://10734885247",
			["mails"] = "rbxassetid://10734885614",
			["map"] = "rbxassetid://10734886202",
			["mappin"] = "rbxassetid://10734886004",
			["mappinoff"] = "rbxassetid://10734885803",
			["maximize"] = "rbxassetid://10734886735",
			["maximize2"] = "rbxassetid://10734886496",
			["medal"] = "rbxassetid://10734887072",
			["megaphone"] = "rbxassetid://10734887454",
			["megaphoneoff"] = "rbxassetid://10734887311",
			["meh"] = "rbxassetid://10734887603",
			["menu"] = "rbxassetid://10734887784",
			["messagecircle"] = "rbxassetid://10734888000",
			["messagesquare"] = "rbxassetid://10734888228",
			["mic"] = "rbxassetid://10734888864",
			["mic2"] = "rbxassetid://10734888430",
			["micoff"] = "rbxassetid://10734888646",
			["microscope"] = "rbxassetid://10734889106",
			["microwave"] = "rbxassetid://10734895076",
			["milestone"] = "rbxassetid://10734895310",
			["minimize"] = "rbxassetid://10734895698",
			["minimize2"] = "rbxassetid://10734895530",
			["minus"] = "rbxassetid://10734896206",
			["minuscircle"] = "rbxassetid://10734895856",
			["minussquare"] = "rbxassetid://10734896029",
			["monitor"] = "rbxassetid://10734896881",
			["monitoroff"] = "rbxassetid://10734896360",
			["monitorspeaker"] = "rbxassetid://10734896512",
			["moon"] = "rbxassetid://10734897102",
			["morehorizontal"] = "rbxassetid://10734897250",
			["morevertical"] = "rbxassetid://10734897387",
			["mountain"] = "rbxassetid://10734897956",
			["mountainsnow"] = "rbxassetid://10734897665",
			["mouse"] = "rbxassetid://10734898592",
			["mousepointer"] = "rbxassetid://10734898476",
			["mousepointer2"] = "rbxassetid://10734898194",
			["mousepointerclick"] = "rbxassetid://10734898355",
			["move"] = "rbxassetid://10734900011",
			["move3d"] = "rbxassetid://10734898756",
			["movediagonal"] = "rbxassetid://10734899164",
			["movediagonal2"] = "rbxassetid://10734898934",
			["movehorizontal"] = "rbxassetid://10734899414",
			["movevertical"] = "rbxassetid://10734899821",
			["music"] = "rbxassetid://10734905958",
			["music2"] = "rbxassetid://10734900215",
			["music3"] = "rbxassetid://10734905665",
			["music4"] = "rbxassetid://10734905823",
			["navigation"] = "rbxassetid://10734906744",
			["navigation2"] = "rbxassetid://10734906332",
			["navigation2off"] = "rbxassetid://10734906144",
			["navigationoff"] = "rbxassetid://10734906580",
			["network"] = "rbxassetid://10734906975",
			["newspaper"] = "rbxassetid://10734907168",
			["octagon"] = "rbxassetid://10734907361",
			["option"] = "rbxassetid://10734907649",
			["outdent"] = "rbxassetid://10734907933",
			["package"] = "rbxassetid://10734909540",
			["package2"] = "rbxassetid://10734908151",
			["packagecheck"] = "rbxassetid://10734908384",
			["packageminus"] = "rbxassetid://10734908626",
			["packageopen"] = "rbxassetid://10734908793",
			["packageplus"] = "rbxassetid://10734909016",
			["packagesearch"] = "rbxassetid://10734909196",
			["packagex"] = "rbxassetid://10734909375",
			["paintbucket"] = "rbxassetid://10734909847",
			["paintbrush"] = "rbxassetid://10734910187",
			["paintbrush2"] = "rbxassetid://10734910030",
			["palette"] = "rbxassetid://10734910430",
			["palmtree"] = "rbxassetid://10734910680",
			["paperclip"] = "rbxassetid://10734910927",
			["partypopper"] = "rbxassetid://10734918735",
			["pause"] = "rbxassetid://10734919336",
			["pausecircle"] = "rbxassetid://10735024209",
			["pauseoctagon"] = "rbxassetid://10734919143",
			["pentool"] = "rbxassetid://10734919503",
			["pencil"] = "rbxassetid://10734919691",
			["percent"] = "rbxassetid://10734919919",
			["personstanding"] = "rbxassetid://10734920149",
			["phone"] = "rbxassetid://10734921524",
			["phonecall"] = "rbxassetid://10734920305",
			["phoneforwarded"] = "rbxassetid://10734920508",
			["phoneincoming"] = "rbxassetid://10734920694",
			["phonemissed"] = "rbxassetid://10734920845",
			["phoneoff"] = "rbxassetid://10734921077",
			["phoneoutgoing"] = "rbxassetid://10734921288",
			["piechart"] = "rbxassetid://10734921727",
			["piggybank"] = "rbxassetid://10734921935",
			["pin"] = "rbxassetid://10734922324",
			["pinoff"] = "rbxassetid://10734922180",
			["pipette"] = "rbxassetid://10734922497",
			["pizza"] = "rbxassetid://10734922774",
			["plane"] = "rbxassetid://10734922971",
			["play"] = "rbxassetid://10734923549",
			["playcircle"] = "rbxassetid://10734923214",
			["plus"] = "rbxassetid://10734924532",
			["pluscircle"] = "rbxassetid://10734923868",
			["plussquare"] = "rbxassetid://10734924219",
			["podcast"] = "rbxassetid://10734929553",
			["pointer"] = "rbxassetid://10734929723",
			["poundsterling"] = "rbxassetid://10734929981",
			["power"] = "rbxassetid://10734930466",
			["poweroff"] = "rbxassetid://10734930257",
			["printer"] = "rbxassetid://10734930632",
			["puzzle"] = "rbxassetid://10734930886",
			["quote"] = "rbxassetid://10734931234",
			["radio"] = "rbxassetid://10734931596",
			["radioreceiver"] = "rbxassetid://10734931402",
			["rectanglehorizontal"] = "rbxassetid://10734931777",
			["rectanglevertical"] = "rbxassetid://10734932081",
			["recycle"] = "rbxassetid://10734932295",
			["redo"] = "rbxassetid://10734932822",
			["redo2"] = "rbxassetid://10734932586",
			["refreshccw"] = "rbxassetid://10734933056",
			["refreshcw"] = "rbxassetid://10734933222",
			["refrigerator"] = "rbxassetid://10734933465",
			["regex"] = "rbxassetid://10734933655",
			["repeat"] = "rbxassetid://10734933966",
			["repeat1"] = "rbxassetid://10734933826",
			["reply"] = "rbxassetid://10734934252",
			["replyall"] = "rbxassetid://10734934132",
			["rewind"] = "rbxassetid://10734934347",
			["rocket"] = "rbxassetid://10734934585",
			["rockingchair"] = "rbxassetid://10734939942",
			["rotate3d"] = "rbxassetid://10734940107",
			["rotateccw"] = "rbxassetid://10734940376",
			["rotatecw"] = "rbxassetid://10734940654",
			["rss"] = "rbxassetid://10734940825",
			["ruler"] = "rbxassetid://10734941018",
			["russianruble"] = "rbxassetid://10734941199",
			["sailboat"] = "rbxassetid://10734941354",
			["save"] = "rbxassetid://10734941499",
			["scale"] = "rbxassetid://10734941912",
			["scale3d"] = "rbxassetid://10734941739",
			["scaling"] = "rbxassetid://10734942072",
			["scan"] = "rbxassetid://10734942565",
			["scanface"] = "rbxassetid://10734942198",
			["scanline"] = "rbxassetid://10734942351",
			["scissors"] = "rbxassetid://10734942778",
			["screenshare"] = "rbxassetid://10734943193",
			["screenshareoff"] = "rbxassetid://10734942967",
			["scroll"] = "rbxassetid://10734943448",
			["search"] = "rbxassetid://10734943674",
			["send"] = "rbxassetid://10734943902",
			["separatorhorizontal"] = "rbxassetid://10734944115",
			["separatorvertical"] = "rbxassetid://10734944326",
			["server"] = "rbxassetid://10734949856",
			["servercog"] = "rbxassetid://10734944444",
			["servercrash"] = "rbxassetid://10734944554",
			["serveroff"] = "rbxassetid://10734944668",
			["settings"] = "rbxassetid://10734950309",
			["settings2"] = "rbxassetid://10734950020",
			["share"] = "rbxassetid://10734950813",
			["share2"] = "rbxassetid://10734950553",
			["sheet"] = "rbxassetid://10734951038",
			["shield"] = "rbxassetid://10734951847",
			["shieldalert"] = "rbxassetid://10734951173",
			["shieldcheck"] = "rbxassetid://10734951367",
			["shieldclose"] = "rbxassetid://10734951535",
			["shieldoff"] = "rbxassetid://10734951684",
			["shirt"] = "rbxassetid://10734952036",
			["shoppingbag"] = "rbxassetid://10734952273",
			["shoppingcart"] = "rbxassetid://10734952479",
			["shovel"] = "rbxassetid://10734952773",
			["showerhead"] = "rbxassetid://10734952942",
			["shrink"] = "rbxassetid://10734953073",
			["shrub"] = "rbxassetid://10734953241",
			["shuffle"] = "rbxassetid://10734953451",
			["sidebar"] = "rbxassetid://10734954301",
			["sidebarclose"] = "rbxassetid://10734953715",
			["sidebaropen"] = "rbxassetid://10734954000",
			["sigma"] = "rbxassetid://10734954538",
			["signal"] = "rbxassetid://10734961133",
			["signalhigh"] = "rbxassetid://10734954807",
			["signallow"] = "rbxassetid://10734955080",
			["signalmedium"] = "rbxassetid://10734955336",
			["signalzero"] = "rbxassetid://10734960878",
			["siren"] = "rbxassetid://10734961284",
			["skipback"] = "rbxassetid://10734961526",
			["skipforward"] = "rbxassetid://10734961809",
			["skull"] = "rbxassetid://10734962068",
			["slack"] = "rbxassetid://10734962339",
			["slash"] = "rbxassetid://10734962600",
			["slice"] = "rbxassetid://10734963024",
			["sliders"] = "rbxassetid://10734963400",
			["slidershorizontal"] = "rbxassetid://10734963191",
			["smartphone"] = "rbxassetid://10734963940",
			["smartphonecharging"] = "rbxassetid://10734963671",
			["smile"] = "rbxassetid://10734964441",
			["smileplus"] = "rbxassetid://10734964188",
			["snowflake"] = "rbxassetid://10734964600",
			["sofa"] = "rbxassetid://10734964852",
			["sortasc"] = "rbxassetid://10734965115",
			["sortdesc"] = "rbxassetid://10734965287",
			["speaker"] = "rbxassetid://10734965419",
			["sprout"] = "rbxassetid://10734965572",
			["square"] = "rbxassetid://10734965702",
			["star"] = "rbxassetid://10734966248",
			["starhalf"] = "rbxassetid://10734965897",
			["staroff"] = "rbxassetid://10734966097",
			["stethoscope"] = "rbxassetid://10734966384",
			["sticker"] = "rbxassetid://10734972234",
			["stickynote"] = "rbxassetid://10734972463",
			["stopcircle"] = "rbxassetid://10734972621",
			["stretchhorizontal"] = "rbxassetid://10734972862",
			["stretchvertical"] = "rbxassetid://10734973130",
			["strikethrough"] = "rbxassetid://10734973290",
			["subscript"] = "rbxassetid://10734973457",
			["sun"] = "rbxassetid://10734974297",
			["sundim"] = "rbxassetid://10734973645",
			["sunmedium"] = "rbxassetid://10734973778",
			["sunmoon"] = "rbxassetid://10734973999",
			["sunsnow"] = "rbxassetid://10734974130",
			["sunrise"] = "rbxassetid://10734974522",
			["sunset"] = "rbxassetid://10734974689",
			["superscript"] = "rbxassetid://10734974850",
			["swissfranc"] = "rbxassetid://10734975024",
			["switchcamera"] = "rbxassetid://10734975214",
			["sword"] = "rbxassetid://10734975486",
			["swords"] = "rbxassetid://10734975692",
			["syringe"] = "rbxassetid://10734975932",
			["table"] = "rbxassetid://10734976230",
			["table2"] = "rbxassetid://10734976097",
			["tablet"] = "rbxassetid://10734976394",
			["tag"] = "rbxassetid://10734976528",
			["tags"] = "rbxassetid://10734976739",
			["target"] = "rbxassetid://10734977012",
			["tent"] = "rbxassetid://10734981750",
			["terminal"] = "rbxassetid://10734982144",
			["terminalsquare"] = "rbxassetid://10734981995",
			["textcursor"] = "rbxassetid://10734982395",
			["textcursorinput"] = "rbxassetid://10734982297",
			["thermometer"] = "rbxassetid://10734983134",
			["thermometersnowflake"] = "rbxassetid://10734982571",
			["thermometersun"] = "rbxassetid://10734982771",
			["thumbsdown"] = "rbxassetid://10734983359",
			["thumbsup"] = "rbxassetid://10734983629",
			["ticket"] = "rbxassetid://10734983868",
			["timer"] = "rbxassetid://10734984606",
			["timeroff"] = "rbxassetid://10734984138",
			["timerreset"] = "rbxassetid://10734984355",
			["toggleleft"] = "rbxassetid://10734984834",
			["toggleright"] = "rbxassetid://10734985040",
			["tornado"] = "rbxassetid://10734985247",
			["toybrick"] = "rbxassetid://10747361919",
			["train"] = "rbxassetid://10747362105",
			["trash"] = "rbxassetid://10747362393",
			["trash2"] = "rbxassetid://10747362241",
			["treedeciduous"] = "rbxassetid://10747362534",
			["treepine"] = "rbxassetid://10747362748",
			["trees"] = "rbxassetid://10747363016",
			["trendingdown"] = "rbxassetid://10747363205",
			["trendingup"] = "rbxassetid://10747363465",
			["triangle"] = "rbxassetid://10747363621",
			["trophy"] = "rbxassetid://10747363809",
			["truck"] = "rbxassetid://10747364031",
			["tv"] = "rbxassetid://10747364593",
			["tv2"] = "rbxassetid://10747364302",
			["type"] = "rbxassetid://10747364761",
			["umbrella"] = "rbxassetid://10747364971",
			["underline"] = "rbxassetid://10747365191",
			["undo"] = "rbxassetid://10747365484",
			["undo2"] = "rbxassetid://10747365359",
			["unlink"] = "rbxassetid://10747365771",
			["unlink2"] = "rbxassetid://10747397871",
			["unlock"] = "rbxassetid://10747366027",
			["upload"] = "rbxassetid://10747366434",
			["uploadcloud"] = "rbxassetid://10747366266",
			["usb"] = "rbxassetid://10747366606",
			["user"] = "rbxassetid://10747373176",
			["usercheck"] = "rbxassetid://10747371901",
			["usercog"] = "rbxassetid://10747372167",
			["userminus"] = "rbxassetid://10747372346",
			["userplus"] = "rbxassetid://10747372702",
			["userx"] = "rbxassetid://10747372992",
			["users"] = "rbxassetid://10747373426",
			["utensils"] = "rbxassetid://10747373821",
			["utensilscrossed"] = "rbxassetid://10747373629",
			["venetianmask"] = "rbxassetid://10747374003",
			["verified"] = "rbxassetid://10747374131",
			["vibrate"] = "rbxassetid://10747374489",
			["vibrateoff"] = "rbxassetid://10747374269",
			["video"] = "rbxassetid://10747374938",
			["videooff"] = "rbxassetid://10747374721",
			["view"] = "rbxassetid://10747375132",
			["voicemail"] = "rbxassetid://10747375281",
			["volume"] = "rbxassetid://10747376008",
			["volume1"] = "rbxassetid://10747375450",
			["volume2"] = "rbxassetid://10747375679",
			["volumex"] = "rbxassetid://10747375880",
			["wallet"] = "rbxassetid://10747376205",
			["wand"] = "rbxassetid://10747376565",
			["wand2"] = "rbxassetid://10747376349",
			["watch"] = "rbxassetid://10747376722",
			["waves"] = "rbxassetid://10747376931",
			["webcam"] = "rbxassetid://10747381992",
			["wifi"] = "rbxassetid://10747382504",
			["wifioff"] = "rbxassetid://10747382268",
			["wind"] = "rbxassetid://10747382750",
			["wraptext"] = "rbxassetid://10747383065",
			["wrench"] = "rbxassetid://10747383470",
			["x"] = "rbxassetid://10747384394",
			["xcircle"] = "rbxassetid://10747383819",
			["xoctagon"] = "rbxassetid://10747384037",
			["xsquare"] = "rbxassetid://10747384217",
			["zoomin"] = "rbxassetid://10747384552",
			["zoomout"] = "rbxassetid://10747384679"
                       }

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "CheatGUI"

    local window = Instance.new("Frame")
    window.Name = "MainWindow"
    window.Parent = ScreenGui
    window.Size = UDim2.new(0, 500, 0, 350)
    window.Position = UDim2.new(0.5, -250, 0.5, -175)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.Active = true
    window.Draggable = true
    Instance.new("UICorner", window).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", window)
    stroke.Thickness = 1.5
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0.4

    local gradient = Instance.new("UIGradient", window)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    }
    gradient.Rotation = 90

    local Title = Instance.new("TextLabel", window)
    Title.Text = Info.Title or "Orion"
    Title.Size = UDim2.new(0, 300, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    local SubTitle = Instance.new("TextLabel", window)
    SubTitle.Text = Info.SubTitle or "Orion Subtitle"
    SubTitle.Size = UDim2.new(0, 300, 0, 20)
    SubTitle.Position = UDim2.new(0, 10, 0, 35)
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextSize = 14

    local Separator = Instance.new("Frame", window)
    Separator.Size = UDim2.new(1, -20, 0, 1)
    Separator.Position = UDim2.new(0, 10, 0, 60)
    Separator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

    local VerticalLine = Instance.new("Frame", window)
    VerticalLine.Size = UDim2.new(0, 1, 1, -80)
    VerticalLine.Position = UDim2.new(0, 135, 0, 70)
    VerticalLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    VerticalLine.BorderSizePixel = 0

    local TabScrollFrame = Instance.new("ScrollingFrame", window)
    TabScrollFrame.Size = UDim2.new(0, 120, 1, -80)
    TabScrollFrame.Position = UDim2.new(0, 10, 0, 70)
    TabScrollFrame.BackgroundTransparency = 1
    TabScrollFrame.ScrollBarThickness = 4
    TabScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    TabScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

    local ButtonY = 0
    local Tabs = {}
    local TabList = {}

    function Tabs:MakeTab(TabInfo)
        local Button = Instance.new("TextButton", TabScrollFrame)
        Button.Size = UDim2.new(0, 120, 0, 30)
        Button.Position = UDim2.new(0, 0, 0, ButtonY)
        Button.Text = ""
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.AutoButtonColor = false
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

        local ContentFrame = Instance.new("Frame", Button)
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.ClipsDescendants = true

        local Icon
        if TabInfo.Icon and type(TabInfo.Icon) == "string" then
            Icon = Instance.new("ImageLabel", ContentFrame)
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Position = UDim2.new(0, 5, 0.5, -10)
            Icon.BackgroundTransparency = 1
            local iconKey = string.lower(TabInfo.Icon)
            if Icons[iconKey] then
                Icon.Image = Icons[iconKey]
            elseif string.match(TabInfo.Icon, "^rbxassetid://%d+$") then
                Icon.Image = TabInfo.Icon
            else
                Icon:Destroy()
                Icon = nil
            end
        end

        local TextLabel = Instance.new("TextLabel", ContentFrame)
        TextLabel.Text = TabInfo.Name or "Tab"
        TextLabel.Size = UDim2.new(1, -30, 1, 0)
        TextLabel.Position = UDim2.new(0, 30, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextSize = 14
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        ButtonY = ButtonY + 35
        TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ButtonY)

        local TabContent = Instance.new("ScrollingFrame", window)
        TabContent.Name = TabInfo.Name or "TabContent"
        TabContent.Size = UDim2.new(1, -150, 1, -80)
        TabContent.Position = UDim2.new(0, 140, 0, 70)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = (#TabList == 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
        TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        table.insert(TabList, TabContent)

        Button.MouseButton1Click:Connect(function()
            for _, f in ipairs(TabList) do
                f.Visible = false
            end
            TabContent.Visible = true
            for _, btn in ipairs(TabScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            end
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)

        local elementY = 0
        local TabFunctions = {}

        function TabFunctions:AddSection(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 25)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local sectionLabel = Instance.new("TextLabel", container)
            sectionLabel.Text = info.Name or "Section"
            sectionLabel.Size = UDim2.new(1, 0, 1, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 16
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.TextTransparency = 1

            TweenService:Create(sectionLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + 30
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)
            return container
        end

        function TabFunctions:AddLabel(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local title = Instance.new("TextLabel", container)
            title.Text = info.Name or "Label"
            title.Size = UDim2.new(1, -10, 0, 18)
            title.Position = UDim2.new(0, 5, 0, 5)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTransparency = 1
            title.TextScaled = true
            title.TextWrapped = false

            local content = Instance.new("TextLabel", container)
            content.Text = info.Content or "Texto"
            content.Size = UDim2.new(1, -10, 0, 18)
            content.Position = UDim2.new(0, 5, 0, 25)
            content.BackgroundTransparency = 1
            content.TextColor3 = Color3.fromRGB(180, 180, 180)
            content.Font = Enum.Font.Gotham
            content.TextSize = 13
            content.TextXAlignment = Enum.TextXAlignment.Left
            content.TextTransparency = 1
            content.TextScaled = true
            content.TextWrapped = false

            local TextService = game:GetService("TextService")
            local titleSize = TextService:GetTextSize(
                title.Text,
                title.TextSize,
                title.Font,
                Vector2.new(container.AbsoluteSize.X - 10, math.huge)
            )
            local contentSize = TextService:GetTextSize(
                content.Text,
                content.TextSize,
                content.Font,
                Vector2.new(container.AbsoluteSize.X - 10, math.huge)
            )

            title.Size = UDim2.new(1, -10, 0, titleSize.Y)
            content.Size = UDim2.new(1, -10, 0, contentSize.Y)
            content.Position = UDim2.new(0, 5, 0, 5 + titleSize.Y + 5)

            local containerHeight = titleSize.Y + contentSize.Y + 15
            container.Size = UDim2.new(1, -20, 0, containerHeight)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()

            elementY = elementY + containerHeight + 20
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddButton(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local button = Instance.new("TextButton", container)
            button.Size = UDim2.new(1, -10, 1, -10)
            button.Position = UDim2.new(0, 5, 0, 5)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.Text = info.Name or "Button"
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.AutoButtonColor = false
            button.BorderSizePixel = 0
            button.TextTransparency = 1
            button.BackgroundTransparency = 0.3
            button.ClipsDescendants = true

            local buttonCorner = Instance.new("UICorner", button)
            buttonCorner.CornerRadius = UDim.new(0, 6)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0,
                BackgroundTransparency = 0
            }):Play()

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end)
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end)

            if info.Callback and typeof(info.Callback) == "function" then
                button.MouseButton1Click:Connect(function()
                    info.Callback()
                end)
            end

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddToggle(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1.5

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 6)

            local toggleText = Instance.new("TextLabel", container)
            toggleText.Text = info.Name or "Toggle"
            toggleText.Size = UDim2.new(1, -60, 0, 20)
            toggleText.Position = UDim2.new(0, 10, 0, 5)
            toggleText.BackgroundTransparency = 1
            toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleText.Font = Enum.Font.GothamBold
            toggleText.TextSize = 14
            toggleText.TextXAlignment = Enum.TextXAlignment.Left
            toggleText.TextTransparency = 1

            local toggleDescription = Instance.new("TextLabel", container)
            toggleDescription.Text = info.Description or ""
            toggleDescription.Size = UDim2.new(1, -60, 0, 15)
            toggleDescription.Position = UDim2.new(0, 10, 0, 25)
            toggleDescription.BackgroundTransparency = 1
            toggleDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
            toggleDescription.Font = Enum.Font.Gotham
            toggleDescription.TextSize = 11
            toggleDescription.TextXAlignment = Enum.TextXAlignment.Left
            toggleDescription.TextTransparency = 1
            toggleDescription.TextWrapped = true

            local toggleButton = Instance.new("TextButton", container)
            toggleButton.Size = UDim2.new(0, 50, 0, 24)
            toggleButton.Position = UDim2.new(1, -60, 0.5, -12)
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggleButton.BorderSizePixel = 0
            toggleButton.AutoButtonColor = false
            toggleButton.Text = ""
            toggleButton.ClipsDescendants = true

            local toggleCorner = Instance.new("UICorner", toggleButton)
            toggleCorner.CornerRadius = UDim.new(0, 12)

            local toggleIndicator = Instance.new("Frame", toggleButton)
            toggleIndicator.Size = UDim2.new(0, 20, 0, 20)
            toggleIndicator.Position = UDim2.new(0, 2, 0.5, -10)
            toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleIndicator.BorderSizePixel = 0

            local indicatorCorner = Instance.new("UICorner", toggleIndicator)
            indicatorCorner.CornerRadius = UDim.new(0, 10)

            local isOn = info.Default or false
            local toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(toggleDescription, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()

            local function updateToggle()
                isOn = (isOn == nil) and false or isOn
                toggleBackgroundColor = isOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
                local targetPosition = isOn and UDim2.new(0, 28, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = toggleBackgroundColor
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = targetPosition
                }):Play()
                if info.Callback and typeof(info.Callback) == "function" then
                    info.Callback(isOn)
                end
            end

            toggleButton.MouseButton1Click:Connect(function()
                isOn = not isOn
                updateToggle()
            end)

            toggleButton.MouseEnter:Connect(function()
                if not isOn then
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
                end
            end)
            toggleButton.MouseLeave:Connect(function()
                if not isOn then
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end
            end)

            updateToggle()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        function TabFunctions:AddDropdown(info)
            local container = Instance.new("Frame", TabContent)
            container.Size = UDim2.new(1, -20, 0, 50)
            container.Position = UDim2.new(0, 10, 0, elementY + 20)
            container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            container.BackgroundTransparency = 1
            container.BorderSizePixel = 0

            local stroke = Instance.new("UIStroke", container)
            stroke.Color = Color3.fromRGB(80, 80, 80)
            stroke.Transparency = 0.5
            stroke.Thickness = 1

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 10)

            local title = Instance.new("TextLabel", container)
            title.Text = info.Name or "Dropdown"
            title.Size = UDim2.new(0.6, -100, 0, 20)
            title.Position = UDim2.new(0, 10, 0, 1)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTransparency = 1

            local description = Instance.new("TextLabel", container)
            description.Text = info.Description or ""
            description.Size = UDim2.new(0.6, -100, 0, 20)
            description.Position = UDim2.new(0, 10, 0, 20)
            description.BackgroundTransparency = 1
            description.TextColor3 = Color3.fromRGB(180, 180, 180)
            description.Font = Enum.Font.Gotham
            description.TextSize = 11
            description.TextXAlignment = Enum.TextXAlignment.Left
            description.TextTransparency = 1
            description.TextWrapped = true

            local Dropdown = {
                Values = info.Values or {},
                Value = info.Default,
                Multi = info.Multi or false,
                Buttons = {},
                Opened = false,
                Callback = info.Callback or function() end,
            }

            local DropdownInner = Instance.new("TextButton", container)
            DropdownInner.Size = UDim2.new(0, 160, 0, 30)
            DropdownInner.Position = UDim2.new(1, -10, 0.5, 0)
            DropdownInner.AnchorPoint = Vector2.new(1, 0.5)
            DropdownInner.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownInner.BackgroundTransparency = 0
            DropdownInner.AutoButtonColor = false
            DropdownInner.Text = ""
            DropdownInner.BorderSizePixel = 0
            Instance.new("UICorner", DropdownInner).CornerRadius = UDim.new(0, 8)
            local innerStroke = Instance.new("UIStroke", DropdownInner)
            innerStroke.Transparency = 0.5
            innerStroke.Color = Color3.fromRGB(100, 100, 100)
            local innerGradient = Instance.new("UIGradient", DropdownInner)
            innerGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
            }
            innerGradient.Rotation = 90

            local DropdownDisplay = Instance.new("TextLabel", DropdownInner)
            DropdownDisplay.Text = ""
            DropdownDisplay.Size = UDim2.new(1, -40, 0, 14)
            DropdownDisplay.Position = UDim2.new(0, 12, 0.5, 0)
            DropdownDisplay.AnchorPoint = Vector2.new(0, 0.5)
            DropdownDisplay.BackgroundTransparency = 1
            DropdownDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
            DropdownDisplay.Font = Enum.Font.Gotham
            DropdownDisplay.TextSize = 13
            DropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
            DropdownDisplay.TextTruncate = Enum.TextTruncate.AtEnd

            local DropdownIco = Instance.new("ImageLabel", DropdownInner)
            DropdownIco.Image = "rbxassetid://10709790948"
            DropdownIco.Size = UDim2.fromOffset(14, 14)
            DropdownIco.Position = UDim2.new(1, -10, 0.5, 0)
            DropdownIco.AnchorPoint = Vector2.new(1, 0.5)
            DropdownIco.BackgroundTransparency = 1
            DropdownIco.ImageColor3 = Color3.fromRGB(150, 150, 150)
            DropdownIco.Rotation = 0

            local DropdownListLayout = Instance.new("UIListLayout")
            DropdownListLayout.Padding = UDim.new(0, 4)
            DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local DropdownScrollFrame = Instance.new("ScrollingFrame")
            DropdownScrollFrame.Size = UDim2.new(1, -10, 1, -10)
            DropdownScrollFrame.Position = UDim2.fromOffset(5, 5)
            DropdownScrollFrame.BackgroundTransparency = 1
            DropdownScrollFrame.ScrollBarThickness = 3
            DropdownScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
            DropdownScrollFrame.ScrollBarImageTransparency = 0.7
            DropdownScrollFrame.BorderSizePixel = 0
            DropdownScrollFrame.CanvasSize = UDim2.fromScale(0, 0)
            DropdownScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            DropdownScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            DropdownListLayout.Parent = DropdownScrollFrame

            local DropdownHolderFrame = Instance.new("Frame")
            DropdownHolderFrame.Size = UDim2.fromScale(1, 0)
            DropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownHolderFrame.BackgroundTransparency = 0.1
            Instance.new("UICorner", DropdownHolderFrame).CornerRadius = UDim.new(0, 8)
            local holderStroke = Instance.new("UIStroke", DropdownHolderFrame)
            holderStroke.Color = Color3.fromRGB(100, 100, 100)
            holderStroke.Transparency = 1
            holderStroke.Thickness = 1
            DropdownScrollFrame.Parent = DropdownHolderFrame

            local shadow = Instance.new("ImageLabel", DropdownHolderFrame)
            shadow.BackgroundTransparency = 1
            shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.SliceCenter = Rect.new(23, 23, 277, 277)
            shadow.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(40, 40)
            shadow.Position = UDim2.fromOffset(-20, -20)
            shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            shadow.ImageTransparency = 0.3

            local DropdownHolderCanvas = Instance.new("Frame", window)
            DropdownHolderCanvas.BackgroundTransparency = 1
            DropdownHolderCanvas.Size = UDim2.fromOffset(170, 0)
            DropdownHolderCanvas.Visible = false
            DropdownHolderFrame.Parent = DropdownHolderCanvas
            local sizeConstraint = Instance.new("UISizeConstraint", DropdownHolderCanvas)
            sizeConstraint.MinSize = Vector2.new(170, 0)

            local function RecalculateListPosition()
                local canvasHeight = DropdownHolderCanvas.Size.Y.Offset
                local buttonY = DropdownInner.AbsolutePosition.Y
                DropdownHolderCanvas.Position = UDim2.fromOffset(
                    DropdownInner.AbsolutePosition.X - window.AbsolutePosition.X,
                    buttonY - canvasHeight - 5 -- 5 studs acima do botão
                )
            end

            local ListSizeX = 0
            local function RecalculateListSize()
                local contentHeight = DropdownListLayout.AbsoluteContentSize.Y + 10
                if #Dropdown.Values > 10 then
                    contentHeight = 390
                end
                DropdownHolderCanvas.Size = UDim2.fromOffset(ListSizeX, contentHeight)
                RecalculateListPosition()
            end

            local function RecalculateCanvasSize()
                DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
            end

            -- Inicializar a posição da lista
            RecalculateListPosition()
            RecalculateListSize()

            -- Conexão para arrastar e atualização dinâmica
            local isDragging = false
            local connection
            local function StartPositionUpdate()
                if not connection then
                    connection = RunService.RenderStepped:Connect(function()
                        if Dropdown.Opened and isDragging then
                            RecalculateListPosition()
                        end
                    end)
                end
            end

            local function StopPositionUpdate()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end

            window.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    StartPositionUpdate()
                end
            end)

            window.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)

            DropdownInner.MouseButton1Click:Connect(function()
                if Dropdown.Opened then
                    Dropdown:Close()
                else
                    Dropdown:Open()
                end
                TweenService:Create(DropdownInner, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = Dropdown.Opened and 0.2 or 0
                }):Play()
            end)

            DropdownInner.MouseEnter:Connect(function()
                TweenService:Create(innerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(120, 120, 120)}):Play()
                TweenService:Create(DropdownInner, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
            end)
            DropdownInner.MouseLeave:Connect(function()
                if not Dropdown.Opened then
                    TweenService:Create(innerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 100, 100)}):Play()
                    TweenService:Create(DropdownInner, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
                end
            end)

            UserInputService.InputBegan:Connect(function(input)
                if Dropdown.Opened and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    local absPos, absSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
                    if not (Mouse.X >= absPos.X and Mouse.X <= absPos.X + absSize.X and
                            Mouse.Y >= absPos.Y and Mouse.Y <= absPos.Y + absSize.Y) then
                        Dropdown:Close()
                    end
                end
            end)

            function Dropdown:Open()
                Dropdown.Opened = true
                TabScrollFrame.ScrollingEnabled = false
                DropdownHolderCanvas.Visible = true
                TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Rotation = 180}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 0
                }):Play()
                TweenService:Create(holderStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Transparency = 0.5}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                    Position = UDim2.new(0, 0, 0, -5)
                }):Play()
                RecalculateListPosition() -- Atualiza a posição inicial
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TabScrollFrame.ScrollingEnabled = true
                TweenService:Create(DropdownIco, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Rotation = 0}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 0.1
                }):Play()
                TweenService:Create(holderStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Transparency = 1}):Play()
                TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(0, 0, 0, 10)
                }):Play()
                wait(0.3)
                DropdownHolderCanvas.Visible = false
                StopPositionUpdate()
            end

            function Dropdown:Display()
                local Str = ""
                if Dropdown.Multi then
                    for Value, Bool in pairs(Dropdown.Value) do
                        if Bool then
                            Str = Str .. Value .. ", "
                        end
                    end
                    Str = Str:sub(1, #Str - 1)
                else
                    Str = Dropdown.Value or ""
                end
                DropdownDisplay.Text = (Str == "" and "" or Str)
            end

            function Dropdown:GetActiveValues()
                if Dropdown.Multi then
                    local T = {}
                    for Value, Bool in pairs(Dropdown.Value) do
                        if Bool then
                            table.insert(T, Value)
                        end
                    end
                    return T
                else
                    return Dropdown.Value and 1 or nil
                end
            end

            function Dropdown:BuildDropdownList()
                for _, Element in next, DropdownScrollFrame:GetChildren() do
                    if not Element:IsA("UIListLayout") then
                        Element:Destroy()
                    end
                end

                local Count = 0
                local DropdownList = {}

                for _, Value in ipairs(Dropdown.Values) do
                    local Table = {}
                    Count = Count + 1

                    local button = Instance.new("TextButton", DropdownScrollFrame)
                    button.Size = UDim2.new(1, -5, 0, 34)
                    button.BackgroundTransparency = 1
                    button.ZIndex = 23
                    button.Text = ""
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

                    local checkmark = Instance.new("ImageLabel", button)
                    checkmark.Size = UDim2.fromOffset(14, 14)
                    checkmark.Position = UDim2.new(0, 8, 0.5, 0)
                    checkmark.BackgroundTransparency = 1
                    checkmark.Image = "rbxassetid://1070976000"
                    checkmark.ImageTransparency = 1
                    checkmark.ImageColor3 = Color3.fromRGB(76, 194, 255)

                    local buttonLabel = Instance.new("TextLabel", button)
                    buttonLabel.Text = Value
                    buttonLabel.Size = UDim2.new(1, -30, 1, 0)
                    buttonLabel.Position = UDim2.fromOffset(30, 0)
                    buttonLabel.BackgroundTransparency = 1
                    buttonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    buttonLabel.Font = Enum.Font.Gotham
                    buttonLabel.TextSize = 13
                    buttonLabel.TextXAlignment = Enum.TextXAlignment.Left

                    local Selected
                    if Dropdown.Multi then
                        Selected = Dropdown.Value[Value]
                    else
                        Selected = Dropdown.Value == Value
                    end

                    local function updateButton()
                        if Dropdown.Multi then
                            Selected = Dropdown.Value[Value]
                        else
                            Selected = Dropdown.Value == Value
                        end
                        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            BackgroundTransparency = Selected and 0.7 or 1
                        }):Play()
                        TweenService:Create(checkmark, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            ImageTransparency = (Dropdown.Multi and Selected) and 0 or 1
                        }):Play()
                    end

                    button.MouseEnter:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.6 or 0.85,
                            Size = UDim2.new(1, -5, 0, 35)
                        }):Play()
                    end)
                    button.MouseLeave:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.7 or 1,
                            Size = UDim2.new(1, -5, 0, 34)
                        }):Play()
                    end)
                    button.MouseButton1Down:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.5
                        }):Play()
                    end)
                    button.MouseButton1Up:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.2), {
                            BackgroundTransparency = Selected and 0.6 or 0.85
                        }):Play()
                    end)

                    button.MouseButton1Click:Connect(function()
                        local Try = not Selected
                        if Dropdown:GetActiveValues() == 1 and not Try and not info.Multi then
                            -- Do nothing if single selection and trying to deselect
                        else
                            if Dropdown.Multi then
                                Selected = Try
                                Dropdown.Value[Value] = Selected and true or nil
                            else
                                Selected = Try
                                Dropdown.Value = Selected and Value or nil
                                for _, OtherButton in next, DropdownList do
                                    OtherButton:UpdateButton()
                                end
                            end
                            Table:UpdateButton()
                            Dropdown:Display()
                            if Dropdown.Callback then
                                Dropdown.Callback(Dropdown.Value)
                            end
                        end
                    end)

                    Table.UpdateButton = updateButton
                    DropdownList[button] = Table

                    updateButton()
                    Dropdown:Display()

                    if buttonLabel.TextBounds.X > ListSizeX then
                        ListSizeX = buttonLabel.TextBounds.X + 40
                    end
                end

                ListSizeX = math.max(ListSizeX, 170)
                RecalculateListSize()
                RecalculateCanvasSize()
            end

            function Dropdown:SetValues(NewValues)
                if NewValues then
                    Dropdown.Values = NewValues
                end
                Dropdown:BuildDropdownList()
            end

            function Dropdown:SetValue(Val)
                if Dropdown.Multi then
                    local nTable = {}
                    for _, Value in next, Val do
                        if table.find(Dropdown.Values, Value) then
                            nTable[Value] = true
                        end
                    end
                    Dropdown.Value = nTable
                else
                    if not Val or table.find(Dropdown.Values, Val) then
                        Dropdown.Value = Val
                    end
                end
                Dropdown:BuildDropdownList()
                Dropdown:Display()
                if Dropdown.Callback then
                    Dropdown.Callback(Dropdown.Value)
                end
            end

            local Defaults = {}
            if type(info.Default) == "string" then
                if table.find(Dropdown.Values, info.Default) then
                    table.insert(Defaults, info.Default)
                end
            elseif type(info.Default) == "table" then
                for _, Value in next, info.Default do
                    if table.find(Dropdown.Values, Value) then
                        table.insert(Defaults, Value)
                    end
                end
            elseif type(info.Default) == "number" and Dropdown.Values[info.Default] then
                table.insert(Defaults, Dropdown.Values[info.Default])
            end

            if next(Defaults) then
                if Dropdown.Multi then
                    Dropdown.Value = {}
                    for _, Value in ipairs(Defaults) do
                        Dropdown.Value[Value] = true
                    end
                else
                    Dropdown.Value = Defaults[1]
                end
            elseif Dropdown.Multi then
                Dropdown.Value = {}
            else
                Dropdown.Value = nil
            end

            Dropdown:BuildDropdownList()
            Dropdown:Display()

            TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(description, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
            TweenService:Create(DropdownInner, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
            TweenService:Create(innerStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Transparency = 0.5}):Play()

            elementY = elementY + 60
            TabContent.CanvasSize = UDim2.new(0, 0, 0, elementY)

            return container
        end

        return TabFunctions
    end

    return Tabs
end

return OrionLibV2

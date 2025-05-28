local OrionLibV2 = {}
local Icons = {
    ["activity"] = "rbxassetid://10709791437",
    ["airvent"] = "rbxassetid://10709791532",
    ["alarmcheck"] = "rbxassetid://10709791785",
    ["alarmclock"] = "rbxassetid://10709792020",
    ["alarmminus"] = "rbxassetid://10709792162",
    ["alarmplus"] = "rbxassetid://10709792556",
    ["alertcircle"] = "rbxassetid://10709792737",
    ["alertcircleoutline"] = "rbxassetid://6026568240",
    ["alertoctagon"] = "rbxassetid://10709792936",
    ["alerttriangle"] = "rbxassetid://10709793126",
    ["aligncenter"] = "rbxassetid://10709793348",
    ["alignjustify"] = "rbxassetid://10709793613",
    ["alignleft"] = "rbxassetid://10709793870",
    ["alignright"] = "rbxassetid://10709794060",
    ["anchor"] = "rbxassetid://10709794305",
    ["aperture"] = "rbxassetid://10709794481",
    ["archive"] = "rbxassetid://10709794626",
    ["arrowdown"] = "rbxassetid://10709795222",
    ["arrowdowncircle"] = "rbxassetid://10709794795",
    ["arrowdownleft"] = "rbxassetid://10709794967",
    ["arrowdownright"] = "rbxassetid://10709795103",
    ["arrowleft"] = "rbxassetid://10709795515",
    ["arrowleftcircle"] = "rbxassetid://10709795351",
    ["arrowright"] = "rbxassetid://10709795998",
    ["arrowrightcircle"] = "rbxassetid://10709795746",
    ["arrowup"] = "rbxassetid://10709796505",
    ["arrowupcircle"] = "rbxassetid://10709796122",
    ["arrowupleft"] = "rbxassetid://10709796274",
    ["arrowupright"] = "rbxassetid://10709796382",
    ["asterisk"] = "rbxassetid://10709796676",
    ["atsign"] = "rbxassetid://10709796843",
    ["award"] = "rbxassetid://10709797034",
    ["baby"] = "rbxassetid://10709797225",
    ["barchart"] = "rbxassetid://10709797559",
    ["barchart2"] = "rbxassetid://10709797387",
    ["batterycharging"] = "rbxassetid://10709797789",
    ["bell"] = "rbxassetid://10709798104",
    ["belloff"] = "rbxassetid://10709797963",
    ["bluetooth"] = "rbxassetid://10709798299",
    ["bold"] = "rbxassetid://10709798434",
    ["bomb"] = "rbxassetid://10709798577",
    ["bone"] = "rbxassetid://10709798767",
    ["book"] = "rbxassetid://10709799122",
    ["bookmark"] = "rbxassetid://10709799274",
    ["bookopen"] = "rbxassetid://10709798985",
    ["box"] = "rbxassetid://10709799456",
    ["briefcase"] = "rbxassetid://10709799654",
    ["bug"] = "rbxassetid://10734844673",
    ["building"] = "rbxassetid://10734844852",
    ["building2"] = "rbxassetid://10734844770",
    ["bus"] = "rbxassetid://10709799863",
    ["cake"] = "rbxassetid://10734845061",
    ["calculator"] = "rbxassetid://10709800040",
    ["calendar"] = "rbxassetid://10709800228",
    ["camera"] = "rbxassetid://10709800499",
    ["cameraoff"] = "rbxassetid://10709800386",
    ["car"] = "rbxassetid://10734845230",
    ["cast"] = "rbxassetid://10709800691",
    ["cat"] = "rbxassetid://10734845373",
    ["check"] = "rbxassetid://10709801424",
    ["checkcircle"] = "rbxassetid://10709800875",
    ["checkcircle2"] = "rbxassetid://10709800990",
    ["checkbox"] = "rbxassetid://10709801154",
    ["checksquare"] = "rbxassetid://10709801319",
    ["chevrondown"] = "rbxassetid://10709801615",
    ["chevronleft"] = "rbxassetid://10709801759",
    ["chevronright"] = "rbxassetid://10709801893",
    ["chevronup"] = "rbxassetid://10709802059",
    ["chevronsdown"] = "rbxassetid://10709802251",
    ["chevronsleft"] = "rbxassetid://10709802355",
    ["chevronsright"] = "rbxassetid://10709802511",
    ["chevronsup"] = "rbxassetid://10709802646",
    ["chrome"] = "rbxassetid://10709802799",
    ["circle"] = "rbxassetid://10709802998",
    ["clipboard"] = "rbxassetid://10709803207",
    ["clock"] = "rbxassetid://10709803448",
    ["cloud"] = "rbxassetid://10709805262",
    ["clouddownload"] = "rbxassetid://10709803690",
    ["clouddrizzle"] = "rbxassetid://10709803845",
    ["cloudlightning"] = "rbxassetid://10709803989",
    ["cloudmoon"] = "rbxassetid://10734845532",
    ["cloudoff"] = "rbxassetid://10709804139",
    ["cloudrain"] = "rbxassetid://10709804299",
    ["cloudsnow"] = "rbxassetid://10709804512",
    ["cloudsun"] = "rbxassetid://10734845725",
    ["cloudupload"] = "rbxassetid://10709804774",
    ["code"] = "rbxassetid://10709805422",
    ["codepen"] = "rbxassetid://10709805568",
    ["codesandbox"] = "rbxassetid://10709805706",
    ["coffee"] = "rbxassetid://10709805896",
    ["columns"] = "rbxassetid://10709806071",
    ["command"] = "rbxassetid://10709806226",
    ["compass"] = "rbxassetid://10709806394",
    ["copy"] = "rbxassetid://10709806552",
    ["cornerdownleft"] = "rbxassetid://10709806751",
    ["cornerdownright"] = "rbxassetid://10709806958",
    ["cornerleftdown"] = "rbxassetid://10709807134",
    ["cornerleftup"] = "rbxassetid://10709807307",
    ["cornerrightdown"] = "rbxassetid://10709807573",
    ["cornerrightup"] = "rbxassetid://10709807732",
    ["cornerupleft"] = "rbxassetid://10709807893",
    ["cornerupright"] = "rbxassetid://10709808077",
    ["cpu"] = "rbxassetid://10709808292",
    ["creditcard"] = "rbxassetid://10709808443",
    ["crop"] = "rbxassetid://10709808577",
    ["crosshair"] = "rbxassetid://10709808734",
    ["database"] = "rbxassetid://10709808934",
    ["delete"] = "rbxassetid://10709809059",
    ["disc"] = "rbxassetid://10709809249",
    ["divide"] = "rbxassetid://10709809604",
    ["dividecircle"] = "rbxassetid://10709809351",
    ["dividesquare"] = "rbxassetid://10709809478",
    ["dollar"] = "rbxassetid://10709809749",
    ["dollarsign"] = "rbxassetid://10747359862",
    ["download"] = "rbxassetid://10709810227",
    ["downloadcloud"] = "rbxassetid://10709809926",
    ["droplet"] = "rbxassetid://10709810395",
    ["edit"] = "rbxassetid://10709810708",
    ["edit2"] = "rbxassetid://10709810517",
    ["edit3"] = "rbxassetid://10709810617",
    ["external"] = "rbxassetid://10709810874",
    ["externallink"] = "rbxassetid://10747359979",
    ["eye"] = "rbxassetid://10709811152",
    ["eyeoff"] = "rbxassetid://10709811033",
    ["facebook"] = "rbxassetid://10709811305",
    ["fastforward"] = "rbxassetid://10709811463",
    ["feather"] = "rbxassetid://10709811605",
    ["figma"] = "rbxassetid://10709811727",
    ["file"] = "rbxassetid://10709812439",
    ["fileminus"] = "rbxassetid://10709811911",
    ["fileplus"] = "rbxassetid://10709812099",
    ["filetext"] = "rbxassetid://10709812274",
    ["film"] = "rbxassetid://10709812634",
    ["filter"] = "rbxassetid://10709812803",
    ["flag"] = "rbxassetid://10709812985",
    ["folder"] = "rbxassetid://10709813552",
    ["folderminus"] = "rbxassetid://10709813144",
    ["folderplus"] = "rbxassetid://10709813362",
    ["framer"] = "rbxassetid://10709813711",
    ["frown"] = "rbxassetid://10709813843",
    ["gift"] = "rbxassetid://10709813981",
    ["gitbranch"] = "rbxassetid://10709814127",
    ["gitcommit"] = "rbxassetid://10709814270",
    ["github"] = "rbxassetid://10709814421",
    ["gitlab"] = "rbxassetid://10709814591",
    ["glasses"] = "rbxassetid://10734845911",
    ["globe"] = "rbxassetid://10709814921",
    ["globe2"] = "rbxassetid://10709814734",
    ["grid"] = "rbxassetid://10709815038",
    ["grip"] = "rbxassetid://10734846307",
    ["griphorizontal"] = "rbxassetid://10734846033",
    ["gripvertical"] = "rbxassetid://10734846172",
    ["hammer"] = "rbxassetid://10734846438",
    ["hand"] = "rbxassetid://10734846595",
    ["harddrive"] = "rbxassetid://10709815259",
    ["hash"] = "rbxassetid://10709815379",
    ["haze"] = "rbxassetid://10709815520",
    ["headphones"] = "rbxassetid://10709815682",
    ["heart"] = "rbxassetid://10709815844",
    ["help"] = "rbxassetid://10709816028",
    ["helpcircle"] = "rbxassetid://10709815941",
    ["hexagon"] = "rbxassetid://10734846727",
    ["highlighter"] = "rbxassetid://10734846825",
    ["history"] = "rbxassetid://10734846940",
    ["home"] = "rbxassetid://10709816259",
    ["hourglass"] = "rbxassetid://10734847042",
    ["hammer-wrench"] = "rbxassetid://6031260798",
    ["icecream"] = "rbxassetid://10734847165",
    ["image"] = "rbxassetid://10734847299",
    ["inbox"] = "rbxassetid://10734847400",
    ["info"] = "rbxassetid://10734847516",
    ["instagram"] = "rbxassetid://10709816407",
    ["italic"] = "rbxassetid://10734847630",
    ["key"] = "rbxassetid://10734847747",
    ["keyboard"] = "rbxassetid://10709816570",
    ["languages"] = "rbxassetid://10734847908",
    ["laptop"] = "rbxassetid://10734848019",
    ["laptop2"] = "rbxassetid://10709816749",
    ["lastfm"] = "rbxassetid://10709816934",
    ["layers"] = "rbxassetid://10734848124",
    ["layout"] = "rbxassetid://10734848237",
    ["leaf"] = "rbxassetid://10734848332",
    ["library"] = "rbxassetid://10734848443",
    ["lifebuoy"] = "rbxassetid://10709817189",
    ["lightbulb"] = "rbxassetid://10734848572",
    ["link"] = "rbxassetid://10709817569",
    ["link2"] = "rbxassetid://10709817370",
    ["linkedin"] = "rbxassetid://10709817725",
    ["list"] = "rbxassetid://10709817959",
    ["loader"] = "rbxassetid://10709818106",
    ["lock"] = "rbxassetid://10709818317",
    ["login"] = "rbxassetid://10709818447",
    ["logincircle"] = "rbxassetid://10747359006",
    ["logout"] = "rbxassetid://10709818656",
    ["logoutcircle"] = "rbxassetid://10747359135",
    ["mail"] = "rbxassetid://10709818810",
    ["map"] = "rbxassetid://10734848968",
    ["mappin"] = "rbxassetid://10734848777",
    ["maximize"] = "rbxassetid://10734849204",
    ["maximize2"] = "rbxassetid://10734849097",
    ["megaphone"] = "rbxassetid://10734849326",
    ["meh"] = "rbxassetid://10709818997",
    ["menu"] = "rbxassetid://10709819150",
    ["messagecircle"] = "rbxassetid://10709819312",
    ["messagesquare"] = "rbxassetid://10709819508",
    ["mic"] = "rbxassetid://10734849643",
    ["micoff"] = "rbxassetid://10734849513",
    ["minimize"] = "rbxassetid://10734849886",
    ["minimize2"] = "rbxassetid://10734849773",
    ["minus"] = "rbxassetid://10709820040",
    ["minuscircle"] = "rbxassetid://10709819694",
    ["minussquare"] = "rbxassetid://10709819873",
    ["monitor"] = "rbxassetid://10734896360",
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
    ["movie"] = "rbxassetid://10709820203",
    ["music"] = "rbxassetid://10709820369",
    ["navigation"] = "rbxassetid://10734900204",
    ["navigation2"] = "rbxassetid://10734900101",
    ["octagon"] = "rbxassetid://10734900318",
    ["package"] = "rbxassetid://10734900451",
    ["pickaxe-hammer"] = "rbxassetid://6031068420",
    ["pickaxe"] = "rbxassetid://6031068439",
    ["paintbucket"] = "rbxassetid://10747359288",
    ["paperclip"] = "rbxassetid://10734900570",
    ["pause"] = "rbxassetid://10734900886",
    ["pausecircle"] = "rbxassetid://10734900693",
    ["pen"] = "rbxassetid://10747359474",
    ["pentool"] = "rbxassetid://10734901015",
    ["percent"] = "rbxassetid://10734901183",
    ["personstanding"] = "rbxassetid://10747359668",
    ["phone"] = "rbxassetid://10734901852",
    ["phonecall"] = "rbxassetid://10734901320",
    ["phoneforwarded"] = "rbxassetid://10734901466",
    ["phoneincoming"] = "rbxassetid://10734901577",
    ["phonemissed"] = "rbxassetid://10734901677",
    ["phoneoff"] = "rbxassetid://10734901779",
    ["phoneoutgoing"] = "rbxassetid://10734901979",
    ["piechart"] = "rbxassetid://10734902115",
    ["play"] = "rbxassetid://10734902473",
    ["playcircle"] = "rbxassetid://10734902287",
    ["plus"] = "rbxassetid://10734902856",
    ["pluscircle"] = "rbxassetid://10734902606",
    ["plussquare"] = "rbxassetid://10734902739",
    ["pocket"] = "rbxassetid://10734902998",
    ["podcast"] = "rbxassetid://10747360102",
    ["pointer"] = "rbxassetid://10734903186",
    ["pound"] = "rbxassetid://10734903314",
    ["power"] = "rbxassetid://10734903670",
    ["poweroff"] = "rbxassetid://10734903535",
    ["printer"] = "rbxassetid://10734903777",
    ["radio"] = "rbxassetid://10734904060",
    ["rain"] = "rbxassetid://10747360270",
    ["recycle"] = "rbxassetid://10734904219",
    ["refreshccw"] = "rbxassetid://10734904358",
    ["refreshcw"] = "rbxassetid://10734904474",
    ["regex"] = "rbxassetid://10734904600",
    ["repeat"] = "rbxassetid://10734904896",
    ["repeat1"] = "rbxassetid://10734904749",
    ["reply"] = "rbxassetid://10734905199",
    ["replyall"] = "rbxassetid://10734905049",
    ["rewind"] = "rbxassetid://10734905347",
    ["rocket"] = "rbxassetid://10747360453",
    ["rotateccw"] = "rbxassetid://10734905484",
    ["rotatecw"] = "rbxassetid://10734905621",
    ["rss"] = "rbxassetid://10734905749",
    ["ruler"] = "rbxassetid://10747360608",
    ["save"] = "rbxassetid://10734905940",
    ["scissors"] = "rbxassetid://10734906095",
    ["screen"] = "rbxassetid://10747360760",
    ["screenoff"] = "rbxassetid://10747360931",
    ["screenon"] = "rbxassetid://10747361133",
    ["search"] = "rbxassetid://10734906293",
    ["send"] = "rbxassetid://10734906403",
    ["server"] = "rbxassetid://10734906595",
    ["settings"] = "rbxassetid://10734906752",
    ["share"] = "rbxassetid://10734907126",
    ["share2"] = "rbxassetid://10734906948",
    ["shield"] = "rbxassetid://10734907442",
    ["shieldoff"] = "rbxassetid://10734907285",
    ["shoppingbag"] = "rbxassetid://10734907560",
    ["shoppingcart"] = "rbxassetid://10747361303",
    ["shuffle"] = "rbxassetid://10734907732",
    ["sidebar"] = "rbxassetid://10734907910",
    ["skipback"] = "rbxassetid://10734908099",
    ["skipforward"] = "rbxassetid://10734908280",
    ["skull"] = "rbxassetid://10747361458",
    ["slack"] = "rbxassetid://10734908415",
    ["slash"] = "rbxassetid://10734908580",
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
    ["scissors"] = "rbxassetid://6031075931",
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
    ["youtube"] = "rbxassetid://10747384552",
    ["zap"] = "rbxassetid://10747384679",
    ["zapoff"] = "rbxassetid://10747384839",
    ["zoomin"] = "rbxassetid://10747384967",
    ["zoomout"] = "rbxassetid://10747385061"
}

function OrionLibV2:MakeWindow(Info)
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local Camera = game:GetService("Workspace").CurrentCamera

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
                DropdownHolderCanvas.Position = UDim2.fromOffset(
                    DropdownInner.AbsolutePosition.X,
                    DropdownInner.AbsolutePosition.Y - canvasHeight - 35
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

            RecalculateListPosition()
            RecalculateListSize()

            DropdownInner:GetPropertyChangedSignal("AbsolutePosition"):Connect(RecalculateListPosition)

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

            UserInputService.InputBegan:Connect(function(Input)
                if Dropdown.Opened and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                    local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
                    if not (Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and
                            Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y) then
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
                    checkmark.Position = UDim2.new(0, 8, 0.5, 1)
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
                    button.MouseButton1:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.5
                        }):Play()
                    end)
                    button.MouseButton1:Connect(function()
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

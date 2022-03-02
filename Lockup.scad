renderGameBox = false;
renderBoard = false;
renderRules = false;
renderPawns = false;
renderTiles = false;
renderPlayersBoard = false;
renderTokens = false;
renderScoringTiles = false;
renderSpellCards = false;
renderTraitCards = false;
renderAutomatCards = false;
renderAutomatLocationCards = false;
renderGoonsCards = false;
renderItemsCards = false;
renderPlayerHelpCards = false;
renderLeaderCards = false;
renderEndGameCards = false;
renderInstantCards = false;
renderCrown = true;
renderHorn = true;
renderBreakoutExpansion = false;
renderTilesHolders = true;

playersColors = [
    "Green", 
    "Red", 
    "Purple", 
    "MediumSlateBlue", 
    "Yellow"
    ];


tokensColors = [
    "Gold",
    "CornflowerBlue",
    "Silver",
    "Chartreuse"
];
automatColor = "DarkGray";
spellCardsColor = "SlateBlue";
traitCardsColor = "AntiqueWhite";
automatCardsColor = "MidnightBlue";
automatLocationCardsColor = "PaleTurquoise";
goonCardsColor = "LimeGreen";
itemCardsColor = "Thistle";
playerHelpCardsColor = "DarkSlateGray";
leaderCardsColor = "Black";
endGameCardsColor = "DimGray";
instantCardsColor = "Gray";
crownColor = "Gold";
hornColor = "FloralWhite";
breakoutColor = "Navy";

cardGap = 3;
topAlignment = 28 + 26;

module organizerInner() {
    echo("Generating organizer inner");
    width = 215;
    depth = 306;
    height = 70-10-1-2;
    
    cube([width, depth, height]);
}
module organizer() {
    difference() {
        organizerInner();
        playersBoardOuter();
        translate([215-32-32,2,19]) {
            playerTilesSetOuter();
        }
        translate([215-32-32,2+32,19]) {
            playerTilesSetOuter();
        }
        translate([215-32-32,2+32+32,19]) {
            playerTilesSetOuter();
        }
        translate([215-32,2+32,19]) {
            playerTilesSetOuter();
        }
        translate([215-32,2+32+32,19]) {
            playerTilesSetOuter();
        }
        translate([215-32,2,topAlignment - (6*2.1)+1]) {
            playersScoringTilesOuter();
        }
        translate([2,117,8]) {
            spellCardsOuter();
        }
        translate([2+22,117,8]) {
            traitCardsOuter();
        }
        translate([2+22+15,117,8]) {
            goonCardsOuter();
        }
        translate([2+22+15+23,117,8]) {
            itemCardsOuter();
        }
        translate([2+22+15+23+22,117,8]) {
            leaderCardsOuter();
        }
        translate([2+22+15+23+22+8,117,8]) {
            endGameCardsOuter();
        }
        translate([2+22+15+23+22+8+7,117,8]) {
            instantCardsOuter();
        }
        translate([2+22+83,117,8]) {
            playerHelpCardsOuter();
        }
        translate([215-2-7,117,8]) {
            automatLocationCardsOuter();
        }
        translate([215-2-7-17,117,8]) {
            automatCardsOuter();
        }
        translate([125,157,topAlignment+2-7]) {
            rotate([90,270,0]) {
                pawnsSetOuter();
            }
        }
    }
}

module tile(color, acrylic) {
    echo("Generating ", color, " tile", "acrylic", acrylic);
    width = 29;
    depth = width;
    color(color) {
        if(acrylic) {
            cube([width, depth, 3]);
        } else {
            cube([width, depth, 2]);
        }
    }
}

module playerTilesSet(color, acrylic) {
    echo("Generating acrylic tiles set for player", color, "acrylic", acrylic);
    tilesQty = 7;
    if (acrylic) {
        translate([0,0,-3.1]) {
            for (a = [1:tilesQty]) {
                translate([0,0,3.1*a]) {
                    tile(color, acrylic);
                }
            }
        }
    } else {
        for (a = [1:tilesQty]) {
            translate([0,0,2.1*(a-1)]) {
                tile(color, acrylic);
            }
        }
    }
}
module playerTilesSetOuter() {
    width = 31;
    depth = width;
    height = (7 * (2.1+3.1)) + 1;
    translate([0,0,1]) {
        cube([width, depth, height]);
    }
}

module playersTilesSet(acrylic = false) {
    echo("Generating players tiles set - acrylic", acrylic);
    for (a = [1:len(playersColors)]) {
        b = floor((a-1)/3);
        c = (a-1)%3;
        translate([c*32, b*32, 0]) {
            playerTilesSet(playersColors[a-1], acrylic);
        }
    }
}

module playersScoringTiles() {
    echo("Generating players scoring tiles set");
    for (a = [1:len(playersColors)]) {
        translate([0, 0, (a-1)*2.1]) {
            tile(playersColors[a-1], false);
        }
    }
    translate([0, 0, len(playersColors) * 2.1]) {
        tile(automatColor, false);
    }
}
module playersScoringTilesOuter() {
    width = 31;
    depth = 31;
    height = (len(playersColors) + 1) * 2.1 + 3;
    
    cube([width, depth, height]);
}
module playerBoard(color) {
    echo("Generating ", color, " board");
    width = 140;
    depth = 110;
    height = 2;
    color(color) {
        cube([width, depth, height]);
    }
}

module playersBoard() {
    echo("Generating players board");
    for (a = [1:len(playersColors)]) {
        translate([0,0,2.2*(a-1)]) {
            playerBoard(playersColors[a-1]);
        }
    }
}
module playersBoardOuter() {
    echo("Generating players board outer box");
    width = 140 + 4;
    depth = 110 + 4;
    height = (len(playersColors) * 2.2) + 4;
    
    translate([-1,1,1]) {
        cube([width, depth, height]);
    }
}

module pawn(color) {
    echo("Generating ", color, " pawn");
    radius = 3.5;
    height = 6.5;
    
    color(color) {
        cylinder(height, radius * 2, radius * 2);
    }
}

module pawnsSet() {
    echo("Generating pawns set");
    translate([0,0,-7]) {
        for (a = [1:len(playersColors)]) {
            translate([0,0,7*a]) {
                pawn(playersColors[a-1]);
            }
        }
    }
}
module pawnsSetOuter() {
    height = (len(playersColors) * 7) + 2;
    cylinder(height, 4.5*2, 4.5*2);
    translate([0,-9,0]) {
        cube([9+2,9*2,height]);
    }
}
module token(color) {
    echo("Generating token", color);
    width = 10;
    depth = width;
    height = width;
    
    color (color) {
        cube([width, depth, height]);
    }
}

module tokensSet(color) {
    tokenQty = 25;
    translate([-10.2, 0, 0]) {
        for (a = [1:tokenQty]) {
            translate([10.2 * a, 0, 0]) {
                token(color);
            }
        }
    }
}

module allTokens() {
    echo("Generating all tokens");
    translate([0, -10.2, 0]) {
        for (a = [1:len(tokensColors)]) {
            translate([0, 10.2 * a, 0]) {
                tokensSet(tokensColors[a-1]);
            }
        }
    }
}

module spellCards(sleeved = false) {
    color(spellCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 19;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved spells cards");
        }
    }
}
module spellCardsOuter() {
    width = 21;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}

module traitCards(sleeved = false) {
    color(traitCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 12;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved trait cards");
        }
    }
}
module traitCardsOuter() {
    width = 14;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module automatCards(sleeved = false) {
    color(automatCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 14;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved automat cards");
        }
    }
}
module automatCardsOuter() {
    width = 16;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module automatLocationCards(sleeved = false) {
    echo("Generating automat location cards");
    color(automatLocationCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 5;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved automat location cards");
        }
    }
}
module automatLocationCardsOuter() {
    width = 8;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module playerHelpCards(sleeved = false) {
    color(playerHelpCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 4;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved player help cards");
        }
    }
}
module playerHelpCardsOuter() {
    width = 6;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module goonCards(sleeved = false) {
    color(goonCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 20;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved goon cards");
        }
    }
}
module goonCardsOuter() {
    width = 22;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module itemCards(sleeved = false) {
    color(leaderCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 19;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved item cards");
        }
    }
}
module itemCardsOuter() {
    width = 21;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module leaderCards(sleeved = false) {
    color(leaderCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 5;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved leader cards");
        }
    }
}
module leaderCardsOuter() {
    width = 7;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module endGameCards(sleeved = false) {
    color(endGameCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 4;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved end game cards");
        }
    }
}
module endGameCardsOuter() {
    width = 6;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module instantCards(sleeved = false) {
    color(instantCardsColor) {
        if (sleeved) {
            width = 47;
            depth = 70;
            height = 5;
            cube([width, depth, height]);
        } else {
            echo("ATTENTION: Please provide dimensions for non-sleeved instant cards");
        }
    }
}
module instantCardsOuter() {
    width = 7;
    depth = 72;
    height = 50;
    
    cube([width, depth, height]);
}
module crown() {
    echo("Generating crown");
    color(crownColor) {
        linear_extrude(12) {
            points = [[0,0], [15,0], [((21-15)/2)+15, 15], [13.5,11], [13,18], [15/2,11], [2,18], [1.5,11], [(-(21-15)/2), 15]];
            polygon(points);
        }
    }
}
module horn() {
    echo("Generating horn");
    width = 40;
    depth = 20;
    height = 10;
    
    color(hornColor) {
        cube([width, depth, height]);
    }
}
module breakout() {
    echo("Generating Breakout expansion box");
    width = 213;
    depth = 146;
    height = 48;
    
    color(breakoutColor) {
        cube([width, depth, height]);
    }
}
module tilesHolder(color) {
    width = 213;
    depth = 22;
    height = 26;
    
    color(color) {
        cube([width, depth, height]);
    }
}
module tilesHolders() {
    echo("Generating tiles holders set");
    for (a = [1:len(playersColors)]) {
        b = floor((a-1)/2);
        c = (a-1)%2;
        translate([0,b*24,c*28]) {
            tilesHolder(playersColors[a-1]);
        }
    }
}
module tilesHoldersOuter() {
}
module rules() {
    echo("Generating rules");
    width = 206;
    depth = 297;
    height = 1;
    color = "MediumPurple";
    
    color(color) {
        cube([width, depth, height]);
    }
}

module board() {
    echo("Generating board");
    width = 208;
    depth = 298;
    height = 10;
    color = "Tan";

    color(color) {
        cube([width, depth, height]);
    }
}

module gameBox() {
    echo("Generating game box");
    difference() {
        gameBoxOuter();
        translate([2,2,2]) {
            gameBoxInner();
        }
    }
}

module gameBoxOuter() {
    echo("Generating outer game box");
    width = 220;
    depth = 311;
    height = 72;
    
    cube([width, depth, height]);
}

module gameBoxInner() {
    echo("Generating inner game box");
    width = 216;
    depth = 307;
    height = 70;
    
    cube([width, depth, height]);
}

if(renderGameBox) {
    translate([-4,-4,-2]) {
        gameBox();
    }
}
if(renderBoard) {
    translate([6,6,60]) {
        board();
    }
}
if(renderRules) {
    translate([6,6,70]) {
        rules();
    }
}
if(renderPawns) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap + 5 + cardGap + 4 + cardGap + 5 + cardGap + 20, 110 + 6 + (70/2) + 5, topAlignment - 3.5*2 - 1+ 3]) {
        rotate([90,0,0]) {
            pawnsSet();
        }
    }
}
if(renderTiles) {
    translate([215-32-32+1, 32+32+29+3, topAlignment-(7*3.1)-(7*2.1)+2]) {
        rotate([0,0,270]) {
            playersTilesSet();
            translate([0, 0, 7*2.1]) {
                playersTilesSet(true);
            }
        }
    }
}
if(renderPlayersBoard) {
    translate([2,3,3]) {
        playersBoard();
    }
}
if(renderTokens) {
    translate([200,0,0]) {
        allTokens();
    }
}
if(renderScoringTiles) {
    translate([215-32+1, 3, topAlignment - (6*2.1)+2]) {
        playersScoringTiles();
    }
}
translate([3,110+8,topAlignment+2+10]) {
if(renderSpellCards) {
    rotate([0,90,0]) {
        spellCards(true);
    }
}
if(renderTraitCards) {
    translate([19 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            traitCards(true);
        }
    }
}
if(renderGoonsCards) {
    translate([19 + cardGap + 12 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            goonCards(true);
        }
    }
}
if(renderItemsCards) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
        itemCards(true);
        }
    }
}
if(renderLeaderCards) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            leaderCards(true);
        }
    }
}
if(renderEndGameCards) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap + 5 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            endGameCards(true);
        }
    }
}
if(renderInstantCards) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap + 5 + cardGap + 4 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            instantCards(true);
        }
    }
}

if(renderPlayerHelpCards) {
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap + 5 + cardGap + 4 + cardGap + 5 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            playerHelpCards(true);
        }
    }
}
if(renderAutomatCards) {
    translate([215-7.5-cardGap - 7*1.5 - cardGap-cardGap-1, 0, 0]) {
        rotate([0,90,0]) {
            automatCards(true);
        }
    }
}
if(renderAutomatLocationCards) {
    translate([215-7.5-cardGap, 0, 0]) {
        rotate([0,90,0]) {
            automatLocationCards(true);
        }
    }
}
}
if(renderCrown) {
    translate([150, 130, topAlignment-12]) {
        crown();
    }
}
if(renderHorn) {
    translate([130,110+6+70-20, topAlignment-10]) {
        horn();
    }
}
if(renderBreakoutExpansion) {
    translate([0,307-2-146,topAlignment-48]) {
        breakout();
    }
}
if(renderTilesHolders) {
    translate([0,110+6+70+6,0]) {
        tilesHolders();
    }
}
//organizer();

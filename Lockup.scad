renderGameBox = false;
renderBoard = false;
renderRules = false;
renderPawns = true;
renderTiles = true;
renderPlayersBoard = true;
renderTokens = false;
renderScoringTiles = true;
renderSpellCards = true;
renderTraitCards = true;
renderAutomatCards = true;
renderAutomatLocationCards = true;
renderGoonsCards = true;
renderItemsCards = true;
renderPlayerHelpCards = true;
renderLeaderCards = true;
renderEndGameCards = true;
renderInstantCards = true;
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
        translate([0,0,-3.2]) {
            for (a = [1:tilesQty]) {
                translate([0,0,3.2*a]) {
                    tile(color, acrylic);
                }
            }
        }
    } else {
        for (a = [1:tilesQty]) {
            translate([0,0,2.2*(a-1)]) {
                tile(color, acrylic);
            }
        }
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
        translate([0, 0, (a-1)*2.2]) {
            tile(playersColors[a-1], false);
        }
    }
    translate([0, 0, len(playersColors) * 2.2]) {
        tile(automatColor, false);
    }
}
module playerBoard(color) {
    echo("Generating ", color, " board");
    width = 140;
    depth = 110;
    height = 2;
    color(color) {
        cube([width, depth, 3]);
    }
}

module playersBoard() {
    echo("Generating players board");
    translate([0,0,-2.2]) {
        for (a = [1:len(playersColors)]) {
            translate([0,0,2.2*a]) {
                playerBoard(playersColors[a-1]);
            }
        }
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
    translate([19 + cardGap + 12 + cardGap + 20 + cardGap + 19 + cardGap + 5 + cardGap + 4 + cardGap + 5 + cardGap + 20, 110 + 6 + (70/2) + 5, topAlignment - 3.5*2 - 1]) {
        rotate([90,0,0]) {
            pawnsSet();
        }
    }
}
if(renderTiles) {
    translate([142, 32+32+29, topAlignment-(7*3.2)-(7*2.2)]) {
        rotate([0,0,270]) {
            playersTilesSet();
            translate([0, 0, 15.6]) {
                playersTilesSet(true);
            }
        }
    }
}
if(renderPlayersBoard) {
    playersBoard();
}
if(renderTokens) {
    translate([200,0,0]) {
        allTokens();
    }
}
if(renderScoringTiles) {
    translate([142+32, 0, topAlignment - (6*2.2)]) {
        playersScoringTiles();
    }
}
translate([0,110+6,topAlignment]) {
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
    translate([120+19 + cardGap + 12 + cardGap + 20 + cardGap, 0, 0]) {
        rotate([0,90,0]) {
            automatCards(true);
        }
    }
}
if(renderAutomatLocationCards) {
    translate([120+19 + cardGap + 12 + cardGap + 20 + cardGap + 14 + cardGap, 0, 0]) {
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
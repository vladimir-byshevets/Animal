 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


library StringComparer{
    function compare(string memory str1, string memory str2) public pure returns (bool) {
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }
}

contract Animal{
    string name;
    string speaks;

    constructor(string memory _name, string memory _speaks){
        name = _name;
        speaks = _speaks;
    }

    function sleep() pure public returns(string memory){
        return "Z-z-z-z-z-z-z";
    }

    function eat(string memory _food) virtual view public returns(string memory){
        return string.concat("Animal eats", _food);
    }

    function speak() view public returns (string memory){
        return string.concat(name, " speak - ", speaks);
    }

}

abstract contract Herbivore is Animal{
    string canEat = "plant";

    function eat(string memory _food)  override view public returns(string memory){
        require(StringComparer.compare(_food, canEat),"Herbivore cannot eat this");
    return "Non-nom";
    }
}

abstract contract Carnivore is Animal{
    string canEat = "meat";

    function eat(string memory _food)  override view public returns(string memory){
        require(StringComparer.compare(_food, canEat),"A meat-eating animal cannot eat this");
    return "Non-nom";
    }
}

abstract contract Omnivore is Animal{

    function eat(string memory _food) override pure public returns(string memory){
        if(StringComparer.compare(_food, "meat") || StringComparer.compare(_food, "plant") || StringComparer.compare(_food, "chocolate")){
            return "Non-nom";
        }
        return string.concat("I eat ", _food);
    }
}

contract Horse is Herbivore{
   string _name = "Horse";
   string _speaks = "Igogo";

   constructor () Animal(_name, _speaks){
   }
}

contract Cow is Herbivore{

   string   _name = "Cow";
   string   _speaks = "Moooo";
   constructor () Animal(_name, _speaks){
   }
}

contract Dog is Animal{
   string   _name = "Dog";
   string   _speaks = "Woof";

   constructor () Animal(_name, _speaks){
   }
    function eat(string memory feed) override pure  public  returns(string memory){

        require(!StringComparer.compare(feed, "chocolate"), "Dogs cannot eat chocolate!");
        if(StringComparer.compare(feed, "meat") || StringComparer.compare(feed, "plant")){
            return string.concat("Dog eats ", feed);
        }
        revert("Dog cannot eat this");
    }

}

contract Wolf is Carnivore{
   string   _name = "Wolf";
   string   _speaks = "Awwwooooo";

   constructor () Animal(_name, _speaks){
   }
}

contract Pig is Omnivore{
   string   _name = "Pig";
   string   _speaks = "Oink oink";

   constructor () Animal(_name, _speaks){
   }
}

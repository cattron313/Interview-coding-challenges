/*Problem: 
In a social graph, given two people A and B, find the distance between them. 
Given: get_neighbors(Person N) -> returns the immediate neighbors of N

A - a1- B
    a2
    a3

Each person has F friends, and lets say distance between A and B is k
Then BFS: O(F^k) 
*/

Array.prototype.concat = function(array) {
    //assumes object passed in is an array
    for (var idx = 0; idx < array.length; idx++) {
        this.push(array[idx]);
    }
};

function add_distance_to_each_neighbor(neighbors, distance) {
    //assumes neighbors is an array and distance is a number
    for (var idx = 0; idx < neighbors.length; idx++) {
        neighbors[idx] = { person: neighbors[idx], distance: distance };
    }
}

function find_match(startPerson, otherStartingPerson) {
// if find_match finds a match, it returns an array with two people objects
// (these people are the same but may have different distances)
// could improve this function adding to an existing tree and balancing instead of creating a new tree every time
    var result = -1;
    // assumes I have access to a library that creates a binary search tree object with a find method
    // find returns object if match or -1 if no match
    var binaryTree = BinarySearchTree.new(otherStartingPerson, personCompare);
    for (var idx = 0; idx < startPerson.length; idx++) {
        if ((var otherMatch = binaryTree.find(startPerson[idx])) !== -1) {
            result = [startPerson[idx], otherMatch];
            break;
        }
    }
    return result;
}

function personCompare(a, b) {
    //assumes each Person has a unique numerical id
    return a.person.id - b.person.id;
}


   
function findDistance(A, B) {
    //assumes that A and B are both Person objects
    var totalDistance = 0;
    var startPerson = [{ person: A, distance: 0}];
    var otherStartingPerson = [{ person: B, distance: 0}]; //other end, if two are connected
    var foundMatch = false;

    if (personCompare(startPerson[0], otherStartingPerson[0]) != 0) {
        //as long as there's a path from A to B, you shouldn't reach the end of either array before finding a match
        for (var idx = 0; idx < startPerson.length; idx++) {
            if (idx == otherStartingPerson.length) {
                break;
            }
            var neighbors = get_neighbors(startPerson[idx].person);
            add_distance_to_each_neighbor(neighbors, startPerson[idx].distance + 1); //creates an object with a person and a total distance from first person in array
            startPerson.concat(neighbors);

            var other_neighbors = get_neighbors(otherStartingPerson[idx].person);
            add_distance_to_each_neighbor(other_neighbors, otherStartingPerson[idx].distance + 1);
            otherStartingPerson.concat(other_neighbors);

            if ((var match = find_match(startPerson, otherStartingPerson)) !== -1) {
                totalDistance = match[0].distance + match[1].distance;
                foundMatch = true;
                break;
            }
        }

        if (!foundMatch) { totalDistance = -1; } //person A and B are not connected
    }
    return totalDistance;
}

/*
A - a1
    b1
    c1
    
   a1 - a2
        b2
        
        b2 - a3 - B
             b3
             c3
             
B - f1
    g1
    i1 - f2
         a3
         
          A
        /    \
      X1     X2
    /          \
   Y1           Z3
  /             |
 B - Y2 - Z1 - Z2
 */         
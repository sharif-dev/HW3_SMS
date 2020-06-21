
class TrieNode {
  var children: [Character:TrieNode] = [:]
  var isFinal: Bool = false
  var value: Character = " "
  var depth: Int = -1
  func setValue(_ valueNode : Character , _ depthGiven:Int){
    value = valueNode
    depth = depthGiven
  }
  func createChildFor(_ character: Character , _ depth:Int) -> TrieNode {
    let node = TrieNode()
    node.setValue(character , depth)
    children[character] = node
    return node
  }
  func getOrCreateChildFor(_ character: Character , _ depth:Int) -> TrieNode {
    if let child = children[character] {
      return child
    } else {
      return createChildFor(character , depth)
    }
  }

}
struct Result {
    static var ResultArr : [String]=[]
}

class Trie {
  var root = TrieNode()
  func insert(_ word: String){
    insert(chars: Array(word))
  }

  func insert(chars: [Character]) {
    var node = root
    var i = 0
    for character in chars {
      node = node.getOrCreateChildFor(character , i)
      i += 1
    }
    node.isFinal = true 
  }
  

}
 func isSafe(i: Int, j : Int, width:Int,height: Int,visited : [[Bool]])->Bool{

      if i>=0 && i<width && j>=0 && j<height && !visited[i][j] {
        return true
      }
      return false

  }

 func searchWord(root: TrieNode, boggle: [[Character]],i:Int, j: Int, width:Int,height: Int, visited : [[Bool]],str: String)
    { 

       
        if root.isFinal == true{
           //print(str)
           Result.ResultArr.append(str)
        }

        var visitedCopy=visited
        if (isSafe(i:i, j:j,width:width,height:height, visited:visitedCopy)) 
        { 

            visitedCopy[i][j] = true; 
       
            for ch in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"{

                if let temp = root.children[ch]
                { 
      
                    if isSafe(i:i+1,j:j+1,width:width,height:height,visited:visitedCopy) && boggle[i+1][j+1]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i+1,j:j+1,width:width,height:height,visited:visitedCopy,str:str+String(ch)); 
                    }
                    if isSafe(i:i,j:j+1,width:width,height:height,visited:visitedCopy) && boggle[i][j+1]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i,j:j+1,width:width,height:height,visited:visitedCopy,str:str+String(ch));
                    }                              
                    if isSafe(i:i-1,j:j+1,width:width,height:height,visited:visitedCopy) && boggle[i-1][j+1]==ch{ 
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i-1,j:j+1,width:width,height:height,visited:visitedCopy,str:str+String(ch)); 
                    }                               
                    if isSafe(i:i+1,j:j,width:width,height:height,visited:visitedCopy) && boggle[i+1][j]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i+1,j:j,width:width,height:height,visited:visitedCopy,str:str+String(ch));
                    }                             
                    if isSafe(i:i+1,j:j-1,width:width,height:height,visited:visitedCopy) && boggle[i+1][j-1]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i+1,j:j-1,width:width,height:height,visited:visitedCopy,str:str+String(ch)); 
                    }                               
                    if isSafe(i:i,j:j-1,width:width,height:height,visited:visitedCopy) && boggle[i][j-1]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i,j:j-1,width:width,height:height,visited:visitedCopy,str:str+String(ch));
                    }                             
                    if isSafe(i:i-1,j:j-1,width:width,height:height,visited:visitedCopy) && boggle[i-1][j-1]==ch{
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i-1,j:j-1,width:width,height:height,visited:visitedCopy,str:str+String(ch)); 
                    }                             
                    if isSafe(i:i-1,j:j,width:width,height:height,visited:visitedCopy) && boggle[i-1][j]==ch{   
                        searchWord(root:root.children[ch]!,boggle:boggle,i:i-1,j:j,width:width,height:height,visited:visitedCopy,str:str+String(ch));  
                    }
                    
                }
            } 
       
            visitedCopy[i][j] = false; 
        } 
        
    }


var myTrie = Trie()

var words = readLine()?.split(separator: " ")
for word in words!{
  myTrie.insert(String(word))
}

var size = readLine()?.split(separator: " ")
var x = Int(size![0])
var y = Int(size![1])
var table: [[Character]] = []
for i in 0...(x! - 1){
  table.append( [] )
  var rowAmounts = readLine()?.split(separator: " ")
  for j in 0...(y! - 1){
    table[i].append(Character(String(rowAmounts![j])))
  }
}


var arr = Array(repeating: Array(repeating: false, count: x!), count: y!)

var str = ""
for i in 0...(x! - 1){
    for j in 0...(y! - 1) {
        if let temp = myTrie.root.children[table[i][j]]{
          str=str + String(table[i][j])
          searchWord(root:myTrie.root.children[table[i][j]]!,boggle:table,i:i,j:j,width:x!,height:y!,visited:arr,str:str)
          str=""   
        }
        
    }
}

let output=Set(Result.ResultArr)
for result in output{
  print(result)
}


using System;
using System.Collections.Generic;

class MainClass {
  public static void Main (string[] args) {
    //init the datastructures
    Dictionary<int, int> combination_counts = new Dictionary<int, int> {};
    Dictionary<int, List<int>> specifics = new Dictionary<int, List<int>> {};
    List<int> wood_lengths = new List<int> {};

    //getting input
    int wood_count = int.Parse(Console.ReadLine());
    int c1 = 0;
    foreach (string wood_string in Console.ReadLine().Split()){
      int wood_length = int.Parse(wood_string);
      int c2 = 0;

      //finding the sum of every 2 wood lengths while not repeating wood pieces
      foreach (int other_length in wood_lengths){
        List<int> sum_details;
        if (!specifics.TryGetValue(wood_length+other_length, out sum_details)){
          sum_details = new List<int> {};
        }

        if (!(sum_details.Contains(c1) || sum_details.Contains(c2))){
          int old_count;
          if (combination_counts.TryGetValue(wood_length+other_length, out old_count)){
            combination_counts[wood_length+other_length] ++;
            specifics[wood_length + other_length].Add(c1);
            specifics[wood_length + other_length].Add(c2);
          }
          else{
            combination_counts[wood_length+other_length] = 1;
            specifics[wood_length + other_length] = new List<int> {c1, c2};
          }
        }
        c2 ++;
      }

      c1 ++;
      wood_lengths.Add(wood_length);
    }
    
    //finding the highest value and how many times we can get it
    int highest_value = -1;
    int occured = 0;

    foreach (KeyValuePair<int, int> pair in combination_counts){
      if (pair.Value > highest_value){
        highest_value = pair.Value;
        occured = 1;
      }else if (pair.Value == highest_value){
        occured ++;
      }
    }
    Console.WriteLine(highest_value + " " + occured);
  }
}
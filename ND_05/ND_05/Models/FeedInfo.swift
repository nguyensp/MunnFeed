//
//  Story.swift
//  ND_05
//
//  Created by Paul Nguyen on 7/5/22.
//

import Foundation

struct FeedInfo: Codable {
    let nextPageId: String
    let stories: [Story]
}

struct Story: Codable {
    let author: String
    let body: String
    let image: ImageInfo
}

struct ImageInfo: Codable {
    let url: String
    let width: Int
    let height: Int
}


/*
 {
     nextPageId = 2;
     stories =     (
                 {
             author = "Chris P. Bacon";
             body = "Hello, is this thing on?";
             id = "E7476758-D8DE-409E-908F-3CA2E691B66A";
             image =             {
                 height = 250;
                 url = "https://andrewmunn.github.io/newsfeed/puppers/puppy1.jpg";
                 width = 400;
             };
         },
                 {
             author = "Xerxes II";
             body = "Do you know why the scarecrow won an award?\n He was outstanding in his field!";
             id = "F085FB96-43F0-4A6A-83EE-675FADEDF653";
             image =             {
                 height = 640;
                 url = "https://andrewmunn.github.io/newsfeed/puppers/puppy2.jpg";
                 width = 960;
             };
         },
                 {
             author = Charlemagne;
             body = "What does a dog and a cellphone have in common?\n Both have Collar ID";
             id = "4460378D-A63F-4C4C-9708-BC4FC6AE3CC8";
             image =             {
                 height = 768;
                 url = "https://andrewmunn.github.io/newsfeed/puppers/puppy3.jpg";
                 width = 614;
             };
         },
                 {
             author = "Henry VIII";
             body = "What's a dog's favorite instrument?\n A Trom-bone!";
             id = "AB32539B-27AA-4CCE-9AF1-FD55D0B74DC0";
             image =             {
                 height = 768;
                 url = "https://andrewmunn.github.io/newsfeed/puppers/puppy4.jpg";
                 width = 576;
             };
         },
                 {
             author = "Ivan the Terrible";
             body = "What concert costs just 45 cents?\n 50 Cent featuring Nickelback!";
             id = "CE06509E-7DC9-4FA7-9739-A3ED5BBB8029";
             image =             {
                 height = 631;
                 url = "https://andrewmunn.github.io/newsfeed/puppers/puppy5.jpg";
                 width = 633;
             };
         }
     );
 }
 
*/

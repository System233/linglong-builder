#!/bin/env node
import {readFile} from 'fs/promises'
const data=await readFile('./list.csv','utf8')
const result=data.split('\n').flatMap(x=>x.split(',',1)).map(x=>x.trim()).filter(x=>!!x.length)
console.log(JSON.stringify(result))
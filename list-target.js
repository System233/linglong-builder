#!/bin/env node
import { readFile } from "fs/promises";
const listFile = process.env.LIST_FILE ?? "./list.csv";
const data = await readFile(listFile, "utf8");
const result = data
  .split("\n")
  .filter((x) => !x.startsWith("#"))
  .flatMap((x) => x.split(",", 1))
  .map((x) => x.trim())
  .filter((x) => !!x.length);
console.log(JSON.stringify(result));

#!/usr/bin/env ocaml

let latex = "xelatex"

let books = [
	"CT诊断学";
	"ICU主治医师手册";
	"X线读片指南";
	"临床心电图详解与诊断";
 	"临床药物治疗学";
	"临床营养学";
	"免疫学";
	"内科治疗指南";
	"内科疾病鉴别诊断学";
	"急诊内科学";
  "病理学";
	"精神病学";
	"腹部影像解剖图谱";
	"药理学"
]

let compile_book bookname = 
	Sys.command (
		Format.sprintf "cd %s && %s -jobname=%s -output-directory=.. main.tex"
		bookname
		latex
		bookname
	) |> ignore

let clean bookname = 
	Sys.command (Format.sprintf "rm -f %s.*" bookname) |> ignore

let usage () = {|
	o- 编译特定书籍: `./compile 书名`
	o- 编译所有书籍: `./compile all`
|} |> print_endline

let _ = 
	match Sys.argv |> Array.to_list with
	| _ :: "all" :: [] ->  List.iter compile_book books
	| _ :: "help" :: [] -> usage ()
	| _ :: "clean" :: "all" :: _ -> List.iter clean books
	| _ :: "clean" :: bookname :: _ -> clean bookname
	| _ :: bookname :: [] -> 
		begin
		 match List.find_opt (fun book -> book = bookname) books with
		 | Some book -> book |> compile_book
		 | None -> Format.printf "没找到 %s\n" bookname
		end
	| _ -> usage ()
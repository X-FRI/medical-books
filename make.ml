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

let deps = [
	"lmodern";
	"amssymb";
	"amsmath";
	"ifxetex";
	"ifluatex";
	"unicode-math";
	"xcolor";
	"xurl";
	"bookmark";
	"hyperref";
	"placeins";
	"longtable";
	"booktabs";
	"graphicx";
	"grffile";
	"framed";
	"multirow";
	"ctex";
	"rotating";
	"tablefootnote";
	"caption";
	"geometry "
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

let deps_install ?(microos = false) () =
	let command = 
		if microos then 
			"sudo transactional-update pkg in" 
		else "sudo zypper in"
	in
	List.fold_left (fun command package -> Printf.sprintf " %s texlive-%s" command package) command deps
	|> (fun cmd -> cmd ^ " texlive-xetex")
	|> Sys.command
	|> ignore

let usage () = {|
	o- 编译特定书籍: `./make.ml 书名`
	o- 编译所有书籍: `./make.ml all`
	o- 清空编译结果: `./make.ml clean 书名`
	o- 下载所有依赖 (openSUSE only): `./make.ml deps install`
	o- 清空所有编译结果: `./make.ml clean all`
|} |> print_endline

let _ = 
	match Sys.argv |> Array.to_list with
	| _ :: "all" :: [] ->  List.iter compile_book books
	| _ :: "help" :: [] -> usage ()
	| _ :: "clean" :: "all" :: _ -> List.iter clean books
	| _ :: "clean" :: bookname :: _ -> clean bookname
	| _ :: "deps" :: "install" :: "microos" :: _ -> deps_install ~microos:true ()
	| _ :: "deps" :: "install" :: _ -> deps_install ()
	| _ :: bookname :: [] -> 
		begin
		 match List.find_opt (fun book -> book = bookname) books with
		 | Some book -> book |> compile_book
		 | None -> Format.printf "没找到 %s\n" bookname
		end
	| _ -> usage ()

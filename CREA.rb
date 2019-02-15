nnname=ARGV[0].to_s
$file=File.open(nnname,"rb")
i=$file.read(4)#pos=>4
def r_fist(_o)
	unk = r_long("V")#unkow
	total_data = r_long("V")
	start_table = r_long("V")
	table_sz = r_long("V")
	files = ttt(r_long("V")) #get file quantity
	unk2 = r_long("V")
	#_ppp=File.new("tmp_list.txt","w")
	_ppp=File.new("un.bms","a")
	print "file table start:0x",$file.pos.to_s(16),"\n"
	for nm in 1..files
		offset = ttt(r_long("V"))#start
		fsize = ttt(r_long("V"))#file size
		name = $file.read(48).unpack("a*").to_s.gsub("[","").gsub("]","").gsub("\\x00","").gsub("\"","")
		#print name
		#puts unk,total_data,start_table,table_sz,files,unk2,offset,fsize
		#_ppp.puts name
		#puts _ppp
		#mk_file(offset,fsize,name)#out save
		#puts $file.pos,r_long("V")
		#_ppp.close
		print "file name:",name,"\n"
		print "start 0x",offset.to_s(16),"\n"
		print "size 0x",fsize.to_s(16),"\n"
		print "room in 0x",$file.pos.to_s(16),"\n"
		_ppp.print "log \"",name,"\" 0x",offset.to_s(16)," 0x",fsize.to_s(16),"\n"
	end
	_ppp.close
end
def ttt(_a)
	return _a.to_s.gsub("[","").gsub("]","").to_i
end
def mk_file(_off,_stop,_na)#offset,file size,make file name
	_org_pos=$file.pos
	_n_file=File.new(_na,"w")#make file
	$file.seek(_off)
	_tmp_r=$file.read(_stop)
	_n_file.syswrite(_tmp_r)
	$file.seek(_org_pos)
	_n_file.close
end
def r_long(_p)
	return $file.read(4).unpack(_p)
end
if i == "CRAE"
	puts "CRAE file"
	r_fist(0)
else
	print "this no CRAE file"
	system "pause"
end
#use quickbms
system "quickbms.exe un.bms #{nnname}"

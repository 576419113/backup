#!/usr/bin/env python3
#使用指南
#参数1为一个或多个由引号括起的环境变量
#参数1...n为多个目标desktop文件，允许的匹配规则为*，一般正常文件名不会包含*否则会被跳过
import sys
import os
import re
args=sys.argv
if(len(args)>2):
    # StringList
    env_list=args[1].split()
    # StringList
    file_list=args[2:]
    app_num=len(args)-1
    for app in file_list:
        if("*" in app):
            app_l=app.split("/")
            dir_s,match_string=app_l[:-1],app_l[-1]
            match_string=match_string.replace("*",".+")
            dir_s="/"+"/".join(dir_s)
            dir_list=os.listdir(dir_s)
            for file in dir_list:
                if(re.match(match_string,file)):
                    file_list.append(dir_s+"/"+file)
        app_num-=1
        if(not app_num):
            break
    for one in file_list:
        if "*" in one:
            continue
        if "=" in one or "/" not in one:
            print("\033[31mEnvironment Varies Error! Missing Quotation Marks! \033[0m")
            sys.exit()
        env_list_copy=env_list
        target=""
        context=[]
        with open(one,"r") as f:
            context=f.readlines()
        for index in range(len(context)):
            if("Exec=" in context[index] and "TryExec=" not in context[index]):
                last=context[index].split("=",maxsplit=1)[1]
                la=last.split(" ")
                if(la[0]=="env"):
                    env_list_copy=[item for item in env_list_copy if item not in la]
                    context[index]="Exec=env "+" ".join(env_list_copy+la[1:])
                else:
                    context[index]="Exec=env "+" ".join(env_list_copy)+" "+context[index][5:]
        with open(one,"w") as f:
            f.writelines(context)

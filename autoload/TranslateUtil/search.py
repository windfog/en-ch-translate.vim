#!/usr/bin/env python
#-*- coding:utf-8 -*-

import hashlib
import json
import vim
if vim.eval('g:python_version') == '2':
    import urllib
else:
    from urllib import request as urllib

appId="23c5f65c598f21c5"
appPwd="ywspAhm4qA58rDT0P8yKJCsSpXDHBE0z"
url="http://openapi.youdao.com/api?q=%s&appKey=%s&salt=%s&sign=%s"

def searchExplainByPython():
    words=vim.eval('a:words').strip()
    salt="ts"
    toBeSignStr=appId+words+salt+appPwd
    sign=getMd5(toBeSignStr)
    
    queryUrl=url % (urllib.quote(words),appId,salt,sign)
    dataBack = urllib.urlopen(queryUrl).read().decode('utf-8')
    try:
        dataJson = json.loads(dataBack)
        showData(dataJson,words)
    except Exception as e:
        print(e)

def getMd5(toBeStr):
    md5=hashlib.md5()
    if vim.eval('g:python_version') == '2':
        md5.update(bytes(toBeStr))
    else:
        md5.update(bytes(toBeStr,encoding='utf-8'))
    return md5.hexdigest()
def showData(rs,words):
    cwin=vim.eval('search#GetExplainWindowID()') 
    vim.command(cwin+' wincmd w')
    cbuf=vim.current.buffer
    vim.command('setl modifiable')
    vim.command('%d _')

    if rs["errorCode"] != '0':
        cbuf.append(words+u" ===>Translate Failure(翻译失败)")
    else:
        cbuf.append(u"查找:  "+words )
        cbuf.append("")
        translations=""
        for item in rs["translation"]:
            translations+=item+" "
        cbuf.append(u"翻译:  "+translations)
        if 'basic' in rs:
            if 'uk-phonetic' in rs['basic']:
                cbuf.append(u"英标:  " + rs['basic']['uk-phonetic'])
            if 'us-phonetic' in rs['basic']:
                cbuf.append(u"美标:  "+rs['basic']['us-phonetic'])
            if 'explains' in rs['basic']:
                cbuf.append("")
                itemName=u"解释:  "
                for item in rs['basic']['explains']:
                    cbuf.append(itemName+item)
                    itemName="       "

    vim.command('0d _')
    vim.command('setl nomodifiable')

__all__ = ['searchExplainByPython']

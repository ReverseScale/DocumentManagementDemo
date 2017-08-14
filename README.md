# DocumentManagementDemo
OC 实现的文件管理 Demo ，支持图片、文本、视频、动图、PDF等

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/download-3.8MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

原本只打算写个看 PDF 的工具，做完后又想共享 iTunes 里的文件，后来直接支持常用的数据类型，又写了个 GIF 切片工具，最后直接起名叫 DocumentManagementDemo 好了😆。

| 名称 |1.列表页 |2.PDF页 |3.GIF页 |4.GIF切片页 |5.文本页 |6.视频页 |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/78455603.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/47552819.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/51828578.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/71948741.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/37268874.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-8-14/10129518.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | PDF 展示 | GIF 展示 | GIF 切片列表 | 文本展示 | 视频播放 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.部分功能使用静态库管理
* 3.展示逻辑清晰，功能实现完善
* 4.具备较高自定义性

## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 第一步 引入头文件
```
#import "OrderDic.h"
```
### 第二步 简单调用
```
[OrderDic order:dic]
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
OrderedDictionaryTools 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io

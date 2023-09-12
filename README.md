
<div align="center">

# LaTeX写的中文开源医学教材

</div>

## 依赖
- lmodern
- amssymb, amsmath
- ifxetex, ifluatex
- unicode-math
- xcolor
- xurl
- bookmark
- hyperref
- placeins
- longtable,booktabs
- graphicx,grffile
- framed
- multirow
- ctex
- rotating
- tablefootnote
- caption
- geometry

## 编译
> 本项目的构建脚本使用 [ocaml](ocaml.org) 编写

- 编译特定书籍: `./make.ml 书名`
- 编译所有书籍: `./make.ml all`
- 清空编译结果: `./make.ml clean 书名`
- 清空所有编译结果: `./make.ml clean all`

### 自定义编译工具

在 [./make.ml](./make.ml) 中设置latex的值:
```ocaml
let latex = "xelatex"
```

## 计划
- [x] 精神病学
- [x] 临床药物治疗学
- [x] 病理学
- [x] 免疫学
- [x] 腹部影像解剖图谱
- [x] 内科疾病诊断学
- [x] 急诊内科学
- [x] CT诊断学
- [ ] X线读片指南
- [ ] 超声影像学
- [ ] 临床营养学
- [ ] 微生物学
- [ ] 骨科疾病的分类与分型标准
- [ ] 临床心电图详解与诊断
- [ ] 神经系统影像解剖图谱（待定）
- [ ] 临床心电图分析与诊断（待定）
- [ ] 康复护理学
- [ ] 内科治疗指南
- [ ] 临床药物速查手册
- [ ] 药理学


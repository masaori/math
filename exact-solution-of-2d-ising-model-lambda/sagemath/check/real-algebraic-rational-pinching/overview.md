# 実閉部分体の有理挟み込み

**対象ラベル**: `claim_real_algebraic_rational_pinching`

Archimedes 性（`claim_real_algebraic_archimedean`）の本文の各行は `real-algebraic-archimedean` が確かめる。ここでの整数境界の検算は、有理挟み込みの証明が引く $-M<_Ra<_RM$ の前提の確認である。

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 本文の証明の各行（$0<2/n=2/(2f+1)<1/f\le e/f=\varepsilon$、$-Mn\in J$、$j_0\ne Mn$、$-Mn\le j_0<j_0+1\le Mn$、最大性から $s\le_Ra$ でないこと、三分法による $a<_Rs$、$0<_R1/n=j_0/n-r$、$r<_Rj_0/n$、$j_0/n\le_Ra$、推移律による $r<_Ra$、$s-r=2/n<\varepsilon$）を、五つの有理係数多項式の実根（AA）と六組の $\varepsilon$ について厳密に検算する。$<_R$ は差が零でない平方であることで、$\le_R$ は $<_R$ または等号で判定する。否定の対照は $s$ の代わりに $j_0/n$ を取ると $a<_Rs$ が成り立たない例 | PASS（2026-11-12、等号・不等号 199 件、否定の対照 13 件） |

有限例の検算であり、任意の実閉部分体の元に対する証明は本文の論証が担う。実数体への脱出はない（AA は実代数的数の厳密計算として使い、浮動小数点は使わない）。

# SageMath Check: 開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性。q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_density_lower_set_subset_periodic_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$L\le3$、有理点 6 点、所属の証人 1632 組（うち密度を要する段が空でない証人 931 組）、662530 検査。所要 10 秒程度）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda_{\mathbb{Q}}$ で閉じており、実数体も実対数も現れない）。

## 検査内容

周期境界の密度の列 $L\mapsto\Psi_L(q)$ と開境界正方形の密度の列 $L\mapsto\Psi^{\mathrm{op}}_L(q)$ を
$L\in\{1,2,3\}$ で配位の全数え上げから作る（`periodic-density-lower-set-subset-open-square` と同じ模型）。
検査する $\mu$ は、各 $L_0$ の $\Psi^{\mathrm{op}}_{L_0}(q)$ から素数 $2,3,5$ の係数を $-1,-\tfrac12,0,\tfrac13,2$ から選んだ正の
$\varepsilon$ を引いた元で、有限範囲 $N\le L\le3$ で $A^{\mathrm{op}}(q)$ の所属を示せる証人 $(\varepsilon,N)$ の組だけを数える。

証明の中身を段ごとに検査する。

- **準備の第一**（証人の半分 $\varepsilon':=\tfrac12\cdot\varepsilon$）: $\varepsilon'+\varepsilon'=\varepsilon$ の三段、
  $0=0\cdot\varepsilon\le_{\Lambda_{\mathbb{Q}}}\varepsilon'$、$\varepsilon'\ne0$。
- **準備の第二**（$\delta:=-\iota(\log q)$ の符号。$q$ ごとに一度）: $\iota(\log q)\le\iota(\log1)=\iota(0)=0$、
  $0=-0\le\delta$、$0=0\cdot\delta\le2\cdot\delta$。
- **準備の第三**（Archimedes 性）: $2\cdot\delta\le n\cdot\varepsilon'$ を満たす最小の $n$ を有限探索で取り
  （本文は $n$ を明示的に与えるが、ここでは存在だけを使う）、$N':=N+n$ が $N'\ge N\ge1$、$N'\ge n$ を満たすこと。
- **準備の第四**（誤差の比較。密度を要しないので $N'\le L\le60$ で検査）: $\tfrac1L\cdot(2\cdot\delta)\le\varepsilon'$ と
  一続き五段 $-\varepsilon'\le-(\tfrac1L\cdot(2\cdot\delta))=-((\tfrac1L\cdot2)\cdot\delta)=-(\tfrac2L\cdot\delta)=-(\tfrac2L\cdot(-\iota(\log q)))=\tfrac2L\cdot\iota(\log q)$。
- **本体**（密度を要するので $N'\le L\le3$ で検査）: 一続き八段
  $\mu+\varepsilon'=(\mu+\varepsilon')+0=\dots=(\mu+\varepsilon)+(-\varepsilon')\le\Psi^{\mathrm{op}}_L(q)+(-\varepsilon')\le\Psi^{\mathrm{op}}_L(q)+\tfrac2L\cdot\iota(\log q)\le\Psi_L(q)$
  と推移律の結論、および証人 $(\varepsilon',N')$ で $\mu\in A^{\mathrm{per}}(q)$（有限範囲の所属）。
  $N'>3$ の証人では密度を要する段が空になる。空でなかった証人の数を出力に含める（931 組）。

順序は `def_rational_log_order_group_order` の決定手続き（共通分母での証人の $\Lambda$ の比較）で判定する。
有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $q$・$\mu$ についての包含の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/OpenSquareDensityLowerSetSubsetPeriodic.lean`
（`openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one`）、
必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityLowerSetSubsetPeriodic.lean`
（`lowerSetOfSequence_subset_of_eventually_le_add_error_necSuf`）、
導出版 `OpenSquareDensityLowerSetSubsetPeriodicFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/open-square-density-lower-set-subset-periodic/check.sage
```

# SageMath Check: 二つの整数倍のずらしの値から和と積を取り出す

## 対象

**対象ラベル**: `claim_pigeonhole_one_more_than_cardinality`, `claim_two_shifted_values_determine_product`, `claim_two_shifted_values_determine_sum_and_product`

- 実行日: 2026-11-19
- 結果: 全検査通過（PASS 70750）
- 帰属: 鳩の巣は非負整数。和と積の主張の $\alpha,\beta$ は二次体 $\mathbb{Q}(\sqrt2)$・$\mathbb{Q}(\sqrt5)$・$\mathbb{Q}(i)$（Sage の `QuadraticField`。$\overline{\mathbb{Q}}$ の部分体）の元で、部分体 $K$ は $\mathbb{Q}$。浮動小数点は使わない。
- 標本: 鳩の巣は $N=0,\dots,5$ の $P=\{0,\dots,N-1\}$ と、$\mathbb{N}_{<N+1}$ から $P$ への全ての写像（$N^{N+1}$ 個）。和と積は、$t^2-st+p$（$s,p\in\mathbb{Q}$）の二根の組と、和・積が $\mathbb{Q}$ に入らない組を、$c,c'\in\{-3,\dots,3\}$、$c\ne c'$ の全ての組で。

## 何を確かめるか

- 鳩の巣: 各写像に $c<c'$、$\varphi(c)=\varphi(c')$ の組があること。証明の式鎖について、定義域の元の個数が $N+1$、像が $P$ の部分集合で元の個数が $N$ 以下、像の元の個数が定義域の元の個数より小さいこと。写像の個数が $N^{N+1}$ であること。
- 積: 二つの値 $u,u'$ がともに $\mathbb{Q}$ に入る組で、$c-c'\ne0$、$c-c'\in K$、式鎖 $\alpha\beta=\frac{(c-c')\alpha\beta}{c-c'}=\frac{(\alpha+\beta+c\alpha\beta)-(\alpha+\beta+c'\alpha\beta)}{c-c'}=\frac{u-u'}{c-c'}$ の三つの等号と、最後の値が $\mathbb{Q}$ に入ること。
- 和: $c\in K$、式鎖 $\alpha+\beta=(\alpha+\beta+c\alpha\beta)-c\alpha\beta=u-c\alpha\beta$ の二つの等号と、最後の値が $\mathbb{Q}$ に入ること。
- 対照: $\alpha=\sqrt2$、$\beta=-2+\sqrt2$、$c=1$ では $\alpha+\beta+c\alpha\beta=0\in\mathbb{Q}$ だが $\alpha\beta\notin\mathbb{Q}$。同じ組で $c'\in\{-5,\dots,5\}\setminus\{1\}$ の値はどれも $\mathbb{Q}$ に入らない（前提の値が二つ要る）。

有限個の標本の検算であり、普遍量化された主張の証明ではない。

## 実行方法

```sh
sage check.sage
```

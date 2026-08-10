# SageMath Check: 軌道を 1 つ足した組の全体と、その軌道の上の全単射と残りの組との対の 1 対 1 対応

## 対象

**対象ラベル**: `def_orbit_bijection_set` / `def_orbit_family_on_subset` /
`claim_orbit_family_insert_bijection`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 2 件
  （1 つの軌道の上の全単射の全体 $\mathfrak{B}_O$・軌道の部分集合ごとの置換の組 $\mathfrak{A}(s)$）・
  主張 1 件（$\mathrm{ins}$ と $\mathrm{spl}$ が互いに逆であること）
- 併せて使う定義・主張: `def_row_configuration` / `def_column_translation` /
  `def_row_config_shift` / `def_row_config_shift_iterate` / `def_row_config_orbit` /
  `def_row_config_orbit_set` / `def_orbit_permutation_family`

### 何を確定させるための検証か

本文はここで、有限積の分配則
$\prod_{O\in s}\bigl(\sum_{\psi\in\mathfrak{B}_O}g(O,\psi)\bigr)=\sum_{\alpha\in\mathfrak{A}(s)}\prod_{O\in s}g(O,\alpha(O))$
を $s$ の元の個数についての帰納法で示すための、一歩の部分を用意している。
一歩で必要なのは、軌道を 1 つ足した組の全体 $\mathfrak{A}(\{O_0\}\cup s)$ が
$\mathfrak{B}_{O_0}\times\mathfrak{A}(s)$ と 1 対 1 に対応することである。

1. **定義が定まること。** $\mathfrak{B}_O$ の元が $O$ から $O$ への全単射であること、
   $\mathfrak{A}(s)$ の元が $s$ の各元 $O$ で $\mathfrak{B}_O$ の値を取ること、
   $\mathfrak{A}(\emptyset)$ がちょうど 1 元であること。
   あわせて $\mathfrak{A}(\mathcal{O}_L)$ が前セクションの $\mathfrak{A}_L$ と一致すること。
   **これを別に確かめる理由**: $\mathfrak{A}(s)$ は $s$ を動かせるように定義し直したものなので、
   $s=\mathcal{O}_L$ で前セクションの $\mathfrak{A}_L$ と同じ集合になっていなければ、
   以後の帰納法が別の対象についての議論になってしまう。
2. **所属。** $\mathrm{ins}(\psi,\alpha)$ が $\mathfrak{A}(\{O_0\}\cup s)$ の元であること、
   $\mathrm{spl}(\beta)$ が $\mathfrak{B}_{O_0}\times\mathfrak{A}(s)$ の元であること
   （人手証明が式変形の前に確かめている 2 点）。
3. `claim_orbit_family_insert_bijection` の第 1 の等式
   $\mathrm{spl}(\mathrm{ins}(\psi,\alpha))=(\psi,\alpha)$。
4. 同じく第 2 の等式 $\mathrm{ins}(\mathrm{spl}(\beta))=\beta$。
5. **仮定 $O_0\notin s$ が空回りしていないことの確認。** $O_0\in s$ と取ると
   $\mathrm{ins}$ の場合分けが 2 つの値を与えうること（$\psi\ne\alpha(O_0)$ となる組が実在すること）
   を実際に見つける。仮定を外すと定義そのものが壊れることを示すためである。

### 主張が空でないことの確認

- $L=3$ で軌道の大きさは $1,1,3,3$ であり、$\mathfrak{A}(\mathcal{O}_L)$ は $36$ 個ある
  （すべての軌道が 1 元集合なら $\mathfrak{B}_O$ が 1 個ずつになり、主張は自明になる）。
- $L=3$ で $\lvert\mathfrak{B}_O\rvert>1$ となる軌道が実在する。
- $L\ge2$ で、$O_0\in s$ と取ったときに値が衝突する組が実在する（上記 5）。

$L=1$ では $S$ が恒等写像なので軌道はすべて 1 元集合であり、$\mathfrak{B}_O$ も
$\mathfrak{A}(s)$ も 1 個ずつになる。$L=1$ を走らせているのは、定義が退化した場合でも
壊れないことを見るためである。

### 走らせた範囲（打ち切りを隠さない）

| $L$ | 軌道 $\lvert\mathcal{O}_L\rvert$ | 走らせた $s$ | $\lvert\mathfrak{A}(\mathcal{O}_L)\rvert$ | 往復を確かめた組 |
|---|---|---|---|---|
| 1 | 2 | 全部分集合（4 個） | 1 | 4 |
| 2 | 3 | 全部分集合（8 個） | 2 | 20 |
| 3 | 4 | 全部分集合（16 個） | 36 | 532 |
| 4 | 6 | 空集合・1 元・全体（8 個） | 27648 | 4118 |

$L=4$ で $s$ を全部分集合（64 個）にわたって走らせていないのは、$\mathfrak{A}(s)$ の全列挙が
最大 27648 個になり総当たりが現実的でないためである。**この打ち切りは隠さない。**
$L\le3$ では $s$ を全部分集合にわたって走らせている。

すべて有限集合の上の写像の比較であり、浮動小数点は使っていない
（数として現れるのは個数だけで、$\mathbb{N}$ に属する）。

### 実行

```sh
sage sagemath/check/orbit-family-insert/check.sage
```

### 結果

**2026-08-09 実行、すべて通過。** 出力は上表のとおり
（$L=1,2,3,4$ について定義・所属・往復の 2 等式・仮定の必要性）。

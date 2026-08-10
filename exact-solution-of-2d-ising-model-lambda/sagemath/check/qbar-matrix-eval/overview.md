# SageMath Check: 整係数多項式を成分とする行列の、代数的数における値と、積の保存

## 対象

**対象ラベル**: `def_qbar_matrix_eval`・`claim_qbar_matrix_eval_product`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の定義 1 件と主張 1 件
- 併せて引く定義: `def_matrix_over_row_configs`・`def_matrix_product`（$\mathbb{Z}[x]$ の行列とその積）・
  `def_qbar_matrix`・`def_qbar_matrix_product`（$\overline{\mathbb{Q}}$ の行列とその積）・
  `def_partition_polynomial`（代入の約束）

### 何を確定させるための検証か

シフト行列 $U$ は $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ の元として定義してあり（`def_shift_matrix`）、
その固有値を論じる場所は $\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})$ である。
2 つは成分の型が違う別の対象なので、**行き来する写像に名前を与えないと同一視になる**。
そこで成分ごとの評価 $\mathrm{Ev}_{\xi}$ を定義し、この写像が積を保つことを確かめる。
これが済むと、$U^{L}=I$（`theorem_shift_matrix_order`、$\mathbb{Z}[x]$ での等式）を
$\mathrm{Ev}_{\xi}(U)^{L}=I^{\overline{\mathbb{Q}}}_L$ へ運べる。
固有値が 1 の $L$ 乗根であることは、それと `claim_qbar_eigenvector_pow` を突き合わせて出す。

確かめるのは次の 9 で、1 から 6 は人手証明の鎖の 6 段に 1 対 1 で対応する。

1. 添字集合。行配位の全体 $R_L$ が $2^{L}$ 個の元をもつこと。
2. 鎖の第 1 段。$\mathrm{Ev}_{\xi}$ の定義（成分ごとの代入）。
3. 鎖の第 2 段。$\mathbb{Z}[x]$ の行列の積の定義。
4. 鎖の第 3 段。代入が有限和を保つこと。
5. 鎖の第 4 段。代入が積を保つこと。
6. 鎖の第 5・6 段。$\mathrm{Ev}_{\xi}$ の定義へ戻し、$\overline{\mathbb{Q}}$ の行列の積へまとめること。
7. 主張そのもの。$\mathrm{Ev}_{\xi}(AB)=\mathrm{Ev}_{\xi}(A)\,\mathrm{Ev}_{\xi}(B)$ が全成分で成り立つこと。
8. 主張が空虚でないこと。両辺が零行列でない例があること。
9. 型の区別。左辺の積の成分が $\mathbb{Z}[x]$ の元、評価後の成分が $\overline{\mathbb{Q}}$ の元であること
   （2 つの積が別の演算であることを、成分の住む集合で確かめる）。

### 計算をどこで行っているか（$\overline{\mathbb{Q}}$ の扱い）

整係数多項式環は SageMath の `ZZ['x']`、代数的数の全体は `QQbar`（厳密な代数的数の体）で表した。
代入する $\xi$ には有理数のほか $\sqrt2$・$-\sqrt3$・$\sqrt{-1}$・$\sqrt[3]{5}$ を混ぜてある。
**浮動小数点は使っていない**（`ZZ` / `QQ` / `QQbar` の厳密計算だけ）。実数体にも複素数体にも入っていない。

## 走らせた範囲

- $L=1,2,3$（$R_L$ の元の個数はそれぞれ 2・4・8）、$\xi$ は 7 個。行列の成分は添字の番号から
  決まる規則で選んでいる（乱数を使わないので再現する）。
- 鎖の 6 段は $L$ と $\xi$ ごとに全ての成分について確かめた。

$L=4$ 以降を回していないのは、この主張が $L$ に依存しない一般の有限添字集合についての計算であり
（証明も $R_L$ が有限であることしか使っていない）、$L$ を増やしても新しい場合が現れないためである。

## 実行

```sh
sage sagemath/check/qbar-matrix-eval/check.sage
```

## 結果

**2026-08-10 実行。すべて通過。**

```
== 整係数多項式を成分とする行列の評価と、積の保存 ==
L=1: R_L は 2 元。7 個の ξ について 6 段すべてと Ev_ξ(AB) = Ev_ξ(A)Ev_ξ(B) が成り立ち、値は零行列でない
L=2: R_L は 4 元。7 個の ξ について 6 段すべてと Ev_ξ(AB) = Ev_ξ(A)Ev_ξ(B) が成り立ち、値は零行列でない
L=3: R_L は 8 元。7 個の ξ について 6 段すべてと Ev_ξ(AB) = Ev_ξ(A)Ev_ξ(B) が成り立ち、値は零行列でない
すべて通過
```

## 四層のどこまで済んでいるか

**記述と SageMath まで。Lean 未着手**（具体版・必要十分版とも未作成。次の tick で置く）。

# SageMath 検算: 依存台による局所規則の表現

## 対象

**対象ラベル**: `claim_support_is_minimum_representing_set`

- 併せて検証するラベル: `claim_representable_implies_support_subset`、`claim_support_subset_implies_representable`、`claim_inverse_map_is_ca_iff_support_subset`、`claim_minimal_inverse_neighborhood_finite_decidability`
- 検証範囲: 表現可能性と依存台の包含は $|V|=1,2,3$ の全ての写像 $g:A^V\to A$（$4+16+256=276$ 個）と全ての $S\subseteq V$（組 $(g,S)$ は $2{,}120$ 組）。逆写像の最小近傍は、セル数 $L=2,3,4,5$ の巡回舞台上の全 256 初等 CA 規則のうち大域写像が単射な 124 組 $(L,\text{規則})$
- 全数範囲: 上記の範囲での全数検査であり、一般の有限集合 $V$ についての証明ではない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_representable_iff_support_subset.sage` | 定義どおりの表現可能性（$A^S\to A$ の全 $h$ の走査）と $\operatorname{supp}(g)\subseteq S$ が一致すること。（$\Rightarrow$）と（$\Leftarrow$）を別々に数える | PASS | 2,120 組で一致。表せる組 350、包含を満たす組 350 |
| `check_base_extension_representation.sage` | $\operatorname{supp}(g)\subseteq S$ のとき $g=(g\circ\iota^V_S)\circ\rho^V_S$。底（$V\setminus S$ 上で 0 なら $\iota(\rho\,y)=y$）と帰納段（$w\in V\setminus S$、$y(w)=1$ で $g(y)=g(\varphi_w y)$ かつ $\rho^V_S y=\rho^V_S(\varphi_w y)$）を分離 | PASS | 350 組、帰納段 338 段で一致 |
| `check_support_is_minimum.sage` | $g$ を表せる $S$ の全体に $\operatorname{supp}(g)$ が属し、全ての元に包含され、共通部分に等しいこと | PASS | 276 規則で一致 |
| `check_inverse_map_minimal_neighborhood.sage` | 単射な $F$ について $N^\ast(v)=\operatorname{supp}((F^{-1})_v)$ を一点反転走査で求め（等号検査回数 $\le\lvert V\rvert 2^{\lvert V\rvert}$）、局所規則 $(F^{-1})_v\circ\iota^V_{N^\ast(v)}$ の CA の大域写像が $F^{-1}$ に一致（(2)$\Rightarrow$(1)）、$N^\ast(v)$ から 1 元を除くと $(F^{-1})_v$ が表せない（最小性）、$L=5$・規則 45 で $N^\ast(v)=V$（前章の反例と一致） | PASS | 124 組で一致 |

## 限界と帰属

- 表現可能性 $\iff$ 依存台の包含は $|V|\le3$ の全数検査、逆写像の最小近傍は $L\le5$ の巡回舞台・初等 CA 規則の範囲に限る。一般の場合の根拠は構造化記述の人手証明（$|D(y)|$ についての $\mathbb{N}$ 上の帰納法と、前章の依存台不変性・走査定理）である。
- (1)$\Rightarrow$(2) は「$N^\ast(v)$ を真に縮めた近傍では $(F^{-1})_v$ が表せない」ことを定義どおりの全 $h$ 走査で確認した形であり、任意の $N'$ を走査したものではない。
- $A^S$ と $A^V$ の行き来は制限写像 $\rho^V_S$ と基準値延長写像 $\iota^V_S$ の 2 本だけを通し、巡回舞台の $\ell,r$ は表として与え、剰余類の演算は使わない。
- 全て有限集合の等号と非負整数の比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/local-rule-representation/check_*.sage; do sage "$file"; done
```

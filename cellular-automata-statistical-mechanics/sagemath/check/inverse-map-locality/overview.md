# SageMath 検算: 逆写像の局所性

## 対象

**対象ラベル**: `claim_inverse_support_not_in_neighborhood_counterexample`

- 併せて検証するラベル: `claim_inverse_support_finite_decidability`
- 検証範囲: 本文の反例（5 元集合 $V=\{0,1,2,3,4\}$、表で与えた $\ell,r$、近傍 $\{\ell(v),v,r(v)\}$、8 行の真理値表 $g$ ＝初等 CA 規則 45）について、証明 (1) の像の表、単射性、証明 (2) の 10 組の証人、および逆写像の依存台の一点反転走査を分離して検査する
- 全数範囲: この一つの舞台・一つの規則の全 32 配位（本文の主張がこの有限対象についての主張であるため、全数検査がそのまま主張の範囲を尽くす）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_forward_map_table.sage` | 証明 (1) の表: 32 配位 $y$ と $F\,y$ を定義 $(F\,y)(v)=g(y(\ell(v)),y(v),y(r(v)))$ から再計算し、本文の表と全行一致 | PASS | 32 行で一致 |
| `check_injectivity.sage` | 表の右列 32 個が互いに相異なること（全対 992 組）、定義どおりの単射性（1,024 対の走査） | PASS | 一致 |
| `check_witness_pairs.sage` | 証明 (2) の 10 組 $(v,u,z)$: $u\notin N(v)$、$\varphi_u z$ が $u$ の位置だけの入れ替え、表から読む $F^{-1}(z),F^{-1}(\varphi_u z)$ が本文と一致、$v$ の位置の値が異なる、10 組が各 $v$ の $V\setminus N(v)$（2 元）を尽くす | PASS | 10 行で一致 |
| `check_inverse_support_scan.sage` | 章「本質的依存台の有限決定」の一点反転走査で $\operatorname{supp}((F^{-1})_v)$ を求め、等号検査回数 $\le|V|\cdot2^{|V|}=160$、$V\setminus N(v)\subseteq\operatorname{supp}((F^{-1})_v)$、$\operatorname{supp}((F^{-1})_v)\not\subseteq N(v)$、順写像の同じ走査の依存台が $N(v)$ に含まれること、$\operatorname{supp}((F^{-1})_v)\not\subseteq\operatorname{supp}(f_v\circ\rho^V_{N(v)})$ | PASS | 5 セルで一致。観察（主張しない）: 各セルで $\lvert\operatorname{supp}((F^{-1})_v)\rvert=5$ |

## 限界と帰属

- 反例の claim は 5 元舞台と規則 45 という一つの有限対象についての主張であり、その全 32 配位を検査したので、この claim についてはこの検算が主張の範囲を尽くす。ただし「逆写像の依存台は一般に近傍に収まらない」という否定は、この一つの反例から従う存在主張であって、他の舞台・規則の性質は何も述べない。
- 依存台の有限決定の claim（`claim_inverse_support_finite_decidability`）は一般の単射な大域写像についての主張であり、ここでは上の反例に対する走査回数の検査に限られる。一般の場合の根拠は構造化記述の人手証明（章「本質的依存台の有限決定」の走査定理の適用）である。
- 剰余類の演算は使わず、$\ell,r$ は本文の表どおりの写像として与えた。$F^{-1}$ は像の表を右から左へ読んで作り、単射性の検査とは別ファイルにした。
- 全て有限集合と非負整数の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/inverse-map-locality/check_*.sage; do sage "$file"; done
```

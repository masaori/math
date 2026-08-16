# SageMath 検算: 反復モノイドの安定像による配位集合の分割

## 対象

**対象ラベル**: `claim_iterate_monoid_stable_fiber_cardinality_decomposition`

- 併せて検証するラベル: `def_iterate_monoid_stable_fiber`、`claim_iterate_monoid_stable_representative_belongs_to_fiber`、`claim_iterate_monoid_stable_fiber_unique_representative`、`claim_iterate_monoid_distinct_stable_fibers_disjoint`、`claim_iterate_monoid_stable_fibers_finite_decidability`
- 検証範囲: 安定ファイバー $B_F(q)=\{y\in A^V\mid E_F(y)=q\}$、安定像の各元が自身のファイバーに属すること、各配位がただ一つの安定ファイバーに属すること、異なる安定像の元のファイバーの非交差、個数分解 $\sum_{q\in Q_F}|B_F(q)|=|A^V|=2^{|V|}$、有限真理値表からの全ファイバーと個数の走査
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_representative_belongs.sage` | 各 $q\in Q_F$ で $E_F(q)=q$（前章の恒等性）から定義どおり $q\in B_F(q)$、よって $\lvert B_F(q)\rvert\ge1$ | PASS | 769 写像・安定像の点 2,201 個で成立 |
| `check_unique_representative.sage` | 各 $y\in A^V$ で $E_F(y)\in Q_F$、$y\in B_F(E_F(y))$（存在）、$y\in B_F(q)\cap B_F(r)$ なら $q=E_F(y)=r$（一意性）を等号ごとに検査 | PASS | 769 写像・配位 3,585 個・共通元を持つ組 $(q,r)$ 3,585 件（全て $q=r$）で成立 |
| `check_disjoint.sage` | $q\ne r\in Q_F$ の全組で $B_F(q)\cap B_F(r)=\varnothing$、および $B_F(q)$ の各元 $y$ で $E_F(y)=q\ne r$ | PASS | 769 写像・相異なる組 7,048 件で成立 |
| `check_cardinality_decomposition.sage` | 指示値 $\delta_F(q,y)$ を定め、$\sum_q\lvert B_F(q)\rvert=\sum_q\sum_y\delta=\sum_y\sum_q\delta=\sum_y1=\lvert A^V\rvert=2^{\lvert V\rvert}$ の各等号（内側の和が各 $y$ で $1$ になることを含む）を別々に検査 | PASS | 769 写像で成立 |
| `check_finite_decidability.sage` | 前章の走査で $Q_F$ の表を得た後、各 $y$ の $E_F(y)$ と等しい $q$ のファイバーへ一度だけ加える走査が定義どおりの $B_F(q)$ と個数に一致し、各元がちょうど一度加えられ、総和が $\lvert A^V\rvert$ になること | PASS | 769 写像・配位番号の比較 14,273 回・ファイバーへの追加 3,585 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 非交差の検算は交わりの空判定を直接行う。人手証明は一意性からの背理法なので、共通元が実際に存在しないことの裏取りである。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加算・冪・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-partition/check_*.sage; do sage "$file"; done
```

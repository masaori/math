# SageMath 検算: 有限大域写像の共役による安定ファイバー根付き木族の不変性

## 対象

**対象ラベル**: `claim_iterate_monoid_conjugacy_transports_iterates`

- 併せて検証するラベル: `claim_iterate_monoid_conjugacy_iterate_equality_equivalence`、`claim_iterate_monoid_conjugacy_preserves_collision_start`、`claim_iterate_monoid_conjugacy_preserves_minimal_period`、`claim_iterate_monoid_conjugacy_transports_cycle_idempotent`、`claim_iterate_monoid_conjugacy_transports_stable_image`、`claim_iterate_monoid_conjugacy_transports_stable_fibers`、`claim_iterate_monoid_conjugacy_transports_one_period_map`、`claim_iterate_monoid_conjugacy_transports_one_period_iterates`、`claim_iterate_monoid_conjugacy_one_period_iterate_power`、`claim_iterate_monoid_conjugacy_transports_tree_edges`、`claim_iterate_monoid_conjugacy_preserves_tree_depth`、`claim_iterate_monoid_conjugacy_preserves_tree_branching`、`claim_iterate_monoid_conjugacy_invariant_family_finite_decidability`
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像 $F$）。各 $F$ に対し、配位番号集合上の決定的な全単射（恒等・反転・先頭 2 元の互換・巡回・互換と巡回の合成。重複除去後）を $h$ とし、$G:=h\circ F\circ h^{-1}$ で共役対を作る（計 3,073 対）。反転は辞書式順序での全セル値の反転に一致する。

## 共役対の構成の帰属

任意の自己写像 $A^V\to A^V$ は、近傍 $N(v)=V$ の非一様な 2 値セルオートマトンの大域写像として実現できるので、$G=h\circ F\circ h^{-1}$ も有限舞台上の 2 値セルオートマトンの大域写像であり、対 $(F,G,h)$ は `def_iterate_monoid_conjugacy_bijection` の仮定を満たす（$h\circ F=G\circ h$ は構成から従い、`_common.sage` 内の定義に注記した）。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_iterate_transport.sage` | 反復の移送 $h\circ F^n=G^n\circ h$ と反復等号の両側同値 | PASS | 3,073 対・移送 23,144 段・等号対 97,559 組で成立 |
| `check_invariants_transport.sage` | $\mu_F=\mu_G$、$\Pi$・$D$ の窓内一致、$\lambda_F=\lambda_G$、$e_F=e_G$、$h\circ E_F=E_G\circ h$ | PASS | 3,073 対・所属窓検査 43,215 件で成立 |
| `check_stable_fibers_transport.sage` | $h(Q_F)=Q_G$ と各 $q\in Q_F$ での $h(B_F(q))=B_G(h(q))$・個数一致 | PASS | 3,073 対・ファイバー 9,849 個で成立 |
| `check_one_period_transport.sage` | $h\circ R_F=R_G\circ h$、$h\circ R_F^n=R_G^n\circ h$、$R_F^n=F^{n\lambda_F}$ | PASS | 3,073 対・反復検査 8,912 段で成立 |
| `check_tree_transport.sage` | 根付き辺の保存と反映、根への深さの一致、分岐個数の一致 | PASS | 3,073 対・辺所属対 44,257 組・深さ 16,385 件・分岐 16,385 件で成立 |
| `check_finite_decidability.sage` | 共役の両側で最初の再出現走査から $\mu,\lambda,e,E,Q$・ファイバーを再計算し導出値と一致 | PASS | 走査した写像表 6,146 個で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像・任意の共役全単射に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 共役全単射 $h$ は決定的な 5 種（重複除去後は舞台サイズにより 1〜5 種）に限られ、配位集合上の全ての全単射の全数列挙ではない。
- 全て有限集合上の写像表、有限集合の等号・所属・像・個数、非負整数の除法・乗算・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。
- `check_finite_decidability.sage` の初版は走査上界を点数の 2 倍としていたが、反復列の周期は点数を超えうる（例: 8 点上の 3+5 巡回で周期 15）ため、上界を仮定しない「最初の再出現までの走査」へ実行前に修正した。検査範囲と等号条件は変えていない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-conjugacy-invariance/check_*.sage; do sage "$file"; done
```

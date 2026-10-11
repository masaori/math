# Pfaffian の定義と平方の二重和展開の行別検算

**対象ラベル**: `def_qbar_zero_diagonal_skew_matrix`, `def_qbar_polynomial_pfaffian`, `claim_qbar_polynomial_pfaffian_square_expansion`

本文の十等号を一行一ファイルに対応させる。円分体 $\mathbb Q(\zeta_8)[x]$ 上の厳密計算で、浮動小数点も変数への代入も使わない。添字集合の大きさは零から八。零行列・非有理係数の密行列・隣接二点だけを組む疎行列・二つの列ベクトルから作る反対称行列・上三角が定数一の行列を各大きさで取り、45入力とする。空集合、奇数個の添字、零項、および非零項どうしが相殺する場合を含む。

定義の検算では125個の完全マッチングを重複なく列挙し、転倒数による符号を SageMath の置換符号と比較する。45行列の零対角反対称性を確認し、符号付き和を、先頭の頂点の相手を順に選ぶ独立の再帰式と比較する。順序付き対は対角を含めて重複なく列挙する。括弧と交換則の五行は、全56,305項を個別に比較した後、45個の総和も比較する。

| ファイル | 本文の等号または入力 | 状態 | 結果 |
|---|---|---|---|
| `check_definitions.sage` | 行列・完全マッチング・符号・Pfaffian・順序付き対 | PASS | 125個のマッチングと符号、45行列、45個の独立展開と順序付き対の集合 |
| `check_square_definition.sage` | 平方の定義 | PASS | 45 等式 |
| `check_pfaffian_definition.sage` | Pfaffian の定義を二箇所へ代入 | PASS | 45 等式 |
| `check_distribute_outer.sage` | 外側の和への分配 | PASS | 45 等式 |
| `check_distribute_inner.sage` | 内側の和への分配 | PASS | 45 等式 |
| `check_associate_outer_left.sage` | 外側を左へ結合 | PASS | 56,350 等式 |
| `check_associate_inner_right.sage` | 内側を右へ結合 | PASS | 56,350 等式 |
| `check_commute_middle.sage` | 中央の単項積と符号係数の交換 | PASS | 56,350 等式 |
| `check_associate_inner_left.sage` | 内側を左へ結合 | PASS | 56,350 等式 |
| `check_associate_outer_right.sage` | 外側を右へ結合 | PASS | 56,350 等式 |
| `check_ordered_pairs.sage` | 順序付き対へ再添字付け | PASS | 45 等式 |

このディレクトリで実行する。

```sh
sage -c 'from pathlib import Path
for check_path in sorted(Path(".").glob("check_*.sage")):
    __file__ = str(check_path.resolve())
    load(__file__)'
```

有限個の入力の検算であり、一般の有限集合についての証明は本文と Lean の具体版・必要十分版に置く。行列式との一致はこの検算の対象ではない。

2026-10-11 実行: 全11本が PASS。本文十等号の検算は計281,975等式。定義の確認は上表のとおり別に数える。

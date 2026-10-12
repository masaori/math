# 有限置換の反復の単射性

**対象ラベル**: `claim_finite_permutation_iterate_injective`。

本文の八等号を一行ずつ検算する。大きさ零から六までの全874置換を使い、点には連続しない自然数 `2, 5, 8, …` を割り当てる。帰納段階は回数零から八まで、結論は零から九まで調べる。浮動小数点・実数体を使わない。

仮定を代入する二行は検算した等式の数に含めない。帰納段階の後半は、二つの次段階の反復値が等しい入力に限定し、直前の等式も確認する。全体の結論は等しい入力に絞らず、相異なる二点も全て調べる。件数は入力ごとの確認数であり、同じ値の等式の重複を含む。有限標本の検算は一般の帰納法の証明を代替しない。

| ファイル | 本文の行 | 状態 | 結果 |
|---|---|---|---|
| `check_base_unfold_left.sage` | 零回の反復を左で展開 | PASS | 29,367等式 |
| `check_base_collision.sage` | 零回の二つの反復値が等しいという仮定 | PASS | 5,039仮定代入 |
| `check_base_unfold_right.sage` | 零回の反復を右で展開 | PASS | 29,367等式 |
| `check_successor_fold_left.sage` | 一回進めた始点での反復をまとめる | PASS | 264,303等式 |
| `check_successor_collision.sage` | 次の回数で反復値が等しいという仮定 | PASS | 45,351仮定代入 |
| `check_successor_unfold_right.sage` | 右の反復を再帰により展開 | PASS | 264,303等式 |
| `check_successor_cancel_iteration.sage` | 帰納法の仮定で共通の反復を取り消す | PASS | 45,351等式 |
| `check_successor_cancel_permutation.sage` | 置換の単射性で始点を取り出す | PASS | 45,351等式 |

統合検算は空集合を含む全874置換について、各回数の像の個数も確認する。単射性の仮定を除けない例として、二点を一点へ送る定値写像で、零回の反復は単射だが一回の反復は単射でないことを確認する。

プロジェクト直下から `sage sagemath/check/finite-permutation-iterate-injective/check.sage` を実行する。各 `check_*.sage` も通常の CLI で単独実行できる。

2026-10-12 実行: 八行の全ファイルを単独実行し、六行678,042等式と仮定代入二行50,390例が通過した。統合検算の全874置換・293,670組、空集合の像の個数、非単射な定値写像の反例も通過した。

# 完全マッチングの符号と対列挙の順序独立性の行別検算

**対象ラベル**: `def_perfect_matching_enumeration`, `claim_perfect_matching_enumeration_complete`, `def_matching_word_sign`, `def_perfect_matching_sign`, `claim_matching_word_sign_swap`, `claim_perfect_matching_sign_enumeration_independent`

大きさ零から八までの有限集合で完全マッチングを再帰列挙し、全125個の各マッチングについて対の並べ方をすべて調べる。対の列挙は全2,618通り、端点の隣接交換は18,109通り、隣接二対の四交換は7,746通りである。添字には連続しない自然数を使い、実際の置換を基準列から辞書として構成する。転倒数からの整数符号は Sage の置換の signature とも独立に比較する。

本文の20計算行に各一ファイルを対応させ、定義・完全列挙の入力・両逆・先頭を合わせる帰納法・列挙順序独立性を六ファイルで補う。四交換の各中間列について、重複がなく全元を列挙することを検査する。計算は有限集合・列と `ZZ` の中で閉じ、浮動小数点は使わない。この有限検算は一般の有限集合の証明ではなく、一般の証明は本文と Lean に置く。

| ファイル | 本文の行・検査対象 | 状態 | 結果 |
|---|---|---|---|
| `check_oriented_pairs.sage` | 昇順対の集合の定義 | PASS | 125 集合等式 |
| `check_enumeration_complete.sage` | 実際のマッチングからの列挙と端点の完全列挙 | PASS | 2,618 条件確認 |
| `check_shared_pair_set.sage` | 共有点を持つ組の一意性 | PASS | 944 等式 |
| `check_shared_pair_ordered.sage` | 二元集合の等号と昇順性 | PASS | 944 等式 |
| `check_permutation_definition.sage` | 基準列の各位置と実際の置換 | PASS | 20,726 等式 |
| `check_sign_definition.sage` | 転倒数の符号と独立な Sage 置換符号 | PASS | 2,618 等式 |
| `check_component_definition.sage` | 交換後の置換の成分の定義 | PASS | 143,894 等式 |
| `check_component_swap.sage` | 各位置への値の互換の適用 | PASS | 143,894 等式 |
| `check_component_recover.sage` | 交換前の置換の成分の代入 | PASS | 143,894 等式 |
| `check_swap_sign_definition.sage` | 交換後の語の符号の定義 | PASS | 18,109 等式 |
| `check_swap_sign_composition.sage` | 実際の置換の等号の代入 | PASS | 18,109 等式 |
| `check_swap_sign_multiplication.sage` | 符号の乗法性 | PASS | 18,109 等式 |
| `check_swap_sign_transposition.sage` | 互換の符号の代入 | PASS | 18,109 等式 |
| `check_swap_sign_negation.sage` | 整数の負一倍 | PASS | 18,109 等式 |
| `check_swap_sign_recover.sage` | 交換前の語の符号への復帰 | PASS | 18,109 等式 |
| `check_block_swap_ad.sage` | 最後の隣接交換 | PASS | 7,746 等式 |
| `check_block_swap_bd.sage` | 右側の隣接交換 | PASS | 7,746 等式 |
| `check_block_double_negation_tail.sage` | 最初の二重符号反転の除去 | PASS | 7,746 等式 |
| `check_block_swap_ac.sage` | 左側の隣接交換 | PASS | 7,746 等式 |
| `check_block_swap_bc.sage` | 最初の隣接交換 | PASS | 7,746 等式 |
| `check_block_double_negation_head.sage` | 最後の二重符号反転の除去 | PASS | 7,746 等式 |
| `check_enumeration_route.sage` | 先頭を合わせる隣接交換の帰納法 | PASS | 2,618 経路確認 |
| `check_enumeration_independent.sage` | 全列挙の符号が同じ値となる主張 | PASS | 2,618 等式 |
| `check_empty_matching_definition.sage` | 空マッチングの置換 | PASS | 1 等式 |
| `check_empty_sign_count.sage` | 空集合の転倒数 | PASS | 1 等式 |
| `check_empty_zero_power.sage` | 整数の零乗 | PASS | 1 等式 |

プロジェクトのルートで実行する。

```sh
sage -c 'from pathlib import Path
for p in sorted(Path("sagemath/check/perfect-matching-sign").glob("check_*.sage")):
    load(str(p))'
```

2026-10-11 実行: 全26本が PASS。614,665等式、2,618条件確認、2,618経路確認、125集合等式。

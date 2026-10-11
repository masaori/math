# 完全マッチングと不動点のない対合の行別検算

**対象ラベル**: `def_finite_perfect_matching`, `def_fixed_point_free_involution`, `claim_perfect_matching_involution`

大きさ零から八までの有限集合で完全マッチングを再帰列挙し、別に全置換から不動点のない対合を抽出する。それぞれ全125個を使う。添字は連続しない自然数とし、集合・写像の等号を厳密に比較する。大きさ四以下では二元部分集合の族をすべて列挙し、完全マッチングの定義を独立にも照合する。

本文の29計算行に各一ファイルを対応させ、相手の仕様・二元軌道の分割性・全単射・空集合と奇数集合・定義の照合を別に検査する。有限検算は一般の有限集合についての証明ではなく、一般の証明は本文と Lean に置く。

| ファイル | 本文の行・検査対象 | 状態 | 結果 |
|---|---|---|---|
| `check_exist_first_pair.sage` | 相手の存在: 第一の場合の組の表示 | PASS | 472 等式 |
| `check_exist_first_substitution.sage` | 相手の存在: 第一端点の代入 | PASS | 472 等式 |
| `check_exist_second_pair.sage` | 相手の存在: 第二の場合の組の表示 | PASS | 472 等式 |
| `check_exist_second_substitution.sage` | 相手の存在: 第二端点の代入 | PASS | 472 等式 |
| `check_exist_second_swap.sage` | 相手の存在: 第二の場合の順序交換 | PASS | 472 等式 |
| `check_unique_pair.sage` | 相手の一意性: 含む組の一意性 | PASS | 944 等式 |
| `check_unique_membership.sage` | 相手の一意性: 組の等式の代入 | PASS | 944 所属確認 |
| `check_unique_partner.sage` | 相手の一意性: 自分以外の端点 | PASS | 944 等式 |
| `check_involution_swap.sage` | 相手写像の対合性: 順序交換 | PASS | 944 等式 |
| `check_involution_membership.sage` | 相手写像の対合性: 逆順の組の所属 | PASS | 944 所属確認 |
| `check_involution_mate.sage` | 相手写像の対合性: 戻り先の一意性 | PASS | 944 等式 |
| `check_orbit_first_pair.sage` | 軌道の一意性: 第一の場合の組の表示 | PASS | 944 等式 |
| `check_orbit_first_substitution.sage` | 軌道の一意性: 第一端点の代入 | PASS | 944 等式 |
| `check_orbit_second_apply.sage` | 軌道の一意性: 第二端点へ対合を適用 | PASS | 944 等式 |
| `check_orbit_second_cancel.sage` | 軌道の一意性: 対合の二回適用 | PASS | 944 等式 |
| `check_orbit_second_pair.sage` | 軌道の一意性: 第二の場合の組の表示 | PASS | 944 等式 |
| `check_orbit_second_substitution.sage` | 軌道の一意性: 第二端点の代入 | PASS | 944 等式 |
| `check_orbit_second_mate.sage` | 軌道の一意性: 戻り先の代入 | PASS | 944 等式 |
| `check_orbit_second_swap.sage` | 軌道の一意性: 順序交換 | PASS | 944 等式 |
| `check_left_pair.sage` | 左逆の逆包含: 組の表示 | PASS | 472 等式 |
| `check_left_substitution.sage` | 左逆の逆包含: 相手の一意性 | PASS | 472 等式 |
| `check_left_membership.sage` | 左逆の逆包含: 軌道の族への所属 | PASS | 472 所属確認 |
| `check_left_definition.sage` | 左逆: 合成写像の定義 | PASS | 125 等式 |
| `check_left_inverse.sage` | 左逆: 両包含による族の等号 | PASS | 125 等式 |
| `check_right_definition.sage` | 右逆: 合成写像の点ごとの定義 | PASS | 944 等式 |
| `check_right_inverse.sage` | 右逆: 相手の一意性 | PASS | 944 等式 |
| `check_partner_specification.sage` | 存在・非固定・相手の仕様 | PASS | 944 条件確認 |
| `check_orbit_partition.sage` | 二元軌道の族の完全マッチング条件 | PASS | 125 条件確認 |
| `check_bijection_exhaustive.sage` | 独立に列挙した置換との全単射 | PASS | 9 集合等式 |
| `check_empty_odd.sage` | 空集合と奇数個の集合 | PASS | 5 条件確認 |
| `check_definition_exhaustive.sage` | 小集合の全二元部分集合族による定義の照合 | PASS | 5 集合等式 |
| `check_injective_left.sage` | 単射性: 第一の左逆 | PASS | 125 等式 |
| `check_injective_substitution.sage` | 単射性: 像の等式の代入 | PASS | 125 等式 |
| `check_injective_right.sage` | 単射性: 第二の左逆 | PASS | 125 等式 |

プロジェクトのルートで実行する。

```sh
sage -c 'from pathlib import Path
for p in sorted(Path("sagemath/check/perfect-matching-involution").glob("check_*.sage")):
    load(str(p))'
```

2026-10-11 実行: 全34本が PASS。集合等式14件、条件確認1,074件、等式17,145件、所属確認2,360件。

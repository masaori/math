# 一側閉包の歩ベクトル列の四部分表示

実行日: 2026-10-03。SageMath 10.9 で全25本が通過。

**対象ラベル**: `claim_one_sided_closure_step_sequence`

本文の七場合・25等号を一行ずつ検算する。三つの区間長を各1から5、点列を8種類取り、接合点が一致する整数格子路1,000組を検査する。単位歩、零歩、単位歩以外の差を含む。長さ一の場合も含め、七場合が全ての歩を重複なく覆うことを確認する。有限例の検算であり、全称命題は Lean の二版で証明する。

| ファイル | 対応する等号 | 状態 | 検査数 |
|---|---|---|---|
| `check_first_inside_points.sage` | 第一の区間内部で点列を展開 | PASS | 2,000 |
| `check_first_inside_step.sage` | 第一の歩ベクトルの定義 | PASS | 2,000 |
| `check_first_inside_join.sage` | 第一の連結成分 | PASS | 2,000 |
| `check_first_seam_points.sage` | 第一の接合点で点列を展開 | PASS | 1,000 |
| `check_first_seam_endpoint.sage` | 最初の接合点の一致 | PASS | 1,000 |
| `check_first_seam_step.sage` | 第一の末歩の定義 | PASS | 1,000 |
| `check_first_seam_join.sage` | 第一の末歩の連結 | PASS | 1,000 |
| `check_second_inside_points.sage` | 第二の区間内部で点列を展開 | PASS | 2,000 |
| `check_second_inside_step.sage` | 第二の歩ベクトルの定義 | PASS | 2,000 |
| `check_second_inside_join.sage` | 第二の連結成分 | PASS | 2,000 |
| `check_second_seam_points.sage` | 第二の接合点で点列を展開 | PASS | 1,000 |
| `check_second_seam_endpoint.sage` | 二番目の接合点の一致 | PASS | 1,000 |
| `check_second_seam_step.sage` | 第二の末歩の定義 | PASS | 1,000 |
| `check_second_seam_join.sage` | 第二の末歩の連結 | PASS | 1,000 |
| `check_third_inside_points.sage` | 第三の区間内部で点列を展開 | PASS | 2,000 |
| `check_third_inside_step.sage` | 第三の歩ベクトルの定義 | PASS | 2,000 |
| `check_third_inside_join.sage` | 第三の連結成分 | PASS | 2,000 |
| `check_third_seam_points.sage` | 第三の接合点で点列を展開 | PASS | 1,000 |
| `check_third_seam_endpoint.sage` | 最後の接合点の一致 | PASS | 1,000 |
| `check_third_seam_step.sage` | 第三の末歩の定義 | PASS | 1,000 |
| `check_third_seam_join.sage` | 第三の末歩の連結 | PASS | 1,000 |
| `check_fourth_points.sage` | 第四の区間で点列を展開 | PASS | 3,000 |
| `check_fourth_indices.sage` | 逆向きの添字を計算 | PASS | 3,000 |
| `check_fourth_step.sage` | 逆向きの歩ベクトルの定義 | PASS | 3,000 |
| `check_fourth_join.sage` | 第四の連結成分 | PASS | 3,000 |

`construction.sage` が点列と差の列を作り、`check.sage` が本文の順に全行を実行する。

プロジェクト直下で実行する。

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/one-sided-closure-step-sequence/check.sage
```

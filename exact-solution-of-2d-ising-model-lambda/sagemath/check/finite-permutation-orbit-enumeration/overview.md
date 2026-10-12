# 有限置換の軌道の巡回表示と長さ

**対象ラベル**: `claim_finite_permutation_orbit_enumeration`

要素数0〜6の全874置換と5,039始点を使う。自然数・有限集合だけの厳密計算であり、実数・複素数・浮動小数点を使わない。
最小周期は正の帰還を直接探索し、比較先の軌道は順向きと逆向きの反復をそれぞれ最初の重複まで列挙して独立に構成する。
一歩の等式と帰納法の後者の式は、反復回数0〜2|J|+2で検査する。単点、長さ二の軌道、混在する軌道を含む。
空集合は置換の列挙には含み、始点がないため行の検算件数には含めない。

`check.sage` は本文30行に加えて、台の両包含・短い反復値の相異性・各点の到達の同値も検査する。
一般の自然数回の帰納法は Lean が担い、この有限検算だけを一般の証明とはみなさない。
必要十分版は集合の有限性・全射性・右逆を用いず、左逆と指定した正の最小周期で同じ閉性・帰納法・全単射の論法を行う。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---|
| `check_zero.sage` | e_0=i | PASS | 5,039 |
| `check_period.sage` | e_p=i | PASS | 5,039 |
| `check_last_successor.sage` | (p-1)+1=p | PASS | 5,039 |
| `check_last_lt.sage` | p-1<p | PASS | 5,039 |
| `check_bounded_member.sage` | e_r∈C（r<p） | PASS | 17,203 |
| `check_step_commute.sage` | σ(e_r)=σ^[r](σ(i)) | PASS | 73,851 |
| `check_step_recursion.sage` | σ^[r](σ(i))=e_(r+1) | PASS | 73,851 |
| `check_boundary_index.sage` | r+1=p（r<p かつ r+1≮p） | PASS | 5,039 |
| `check_forward_step.sage` | σ(e_r)=e_(r+1)（境界） | PASS | 5,039 |
| `check_forward_boundary.sage` | e_(r+1)=e_p | PASS | 5,039 |
| `check_forward_return.sage` | e_p=i（境界） | PASS | 5,039 |
| `check_forward_zero.sage` | i=e_0 | PASS | 5,039 |
| `check_backward_zero.sage` | σ⁻¹(e_0)=σ⁻¹(i) | PASS | 5,039 |
| `check_backward_return.sage` | σ⁻¹(i)=σ⁻¹(e_p) | PASS | 5,039 |
| `check_backward_boundary.sage` | σ⁻¹(e_p)=σ⁻¹(e_((p-1)+1)) | PASS | 5,039 |
| `check_backward_step.sage` | σ⁻¹(e_((p-1)+1))=σ⁻¹(σ(e_(p-1))) | PASS | 5,039 |
| `check_backward_cancel.sage` | σ⁻¹(σ(e_(p-1)))=e_(p-1) | PASS | 5,039 |
| `check_predecessor_lt.sage` | k<p（k+1<p） | PASS | 12,164 |
| `check_backward_positive_step.sage` | σ⁻¹(e_(k+1))=σ⁻¹(σ(e_k)) | PASS | 12,164 |
| `check_backward_positive_cancel.sage` | σ⁻¹(σ(e_k))=e_k | PASS | 12,164 |
| `check_reach_zero.sage` | τ^[0](i)=i | PASS | 10,078 |
| `check_reach_zero_point.sage` | i=e_0（帰納法の基底） | PASS | 10,078 |
| `check_reach_zero_member.sage` | e_0∈C（帰納法の基底） | PASS | 10,078 |
| `check_reach_succ_recursion.sage` | τ^[n+1](i)=τ^[n](τ(i)) | PASS | 147,702 |
| `check_reach_succ_commute.sage` | τ^[n](τ(i))=τ(τ^[n](i)) | PASS | 147,702 |
| `check_reach_succ_member.sage` | τ(τ^[n](i))∈C | PASS | 147,702 |
| `check_injective.sage` | θ(r)=θ(t) なら r=t（r,t<p） | PASS | 17,203 |
| `check_card_domain.sage` | p=|I_p| | PASS | 5,039 |
| `check_card_bijection.sage` | |I_p|=|Orb_σ(i)| | PASS | 5,039 |
| `check_card_length.sage` | |Orb_σ(i)|=len_σ(i) | PASS | 5,039 |

## 実行

```sh
sage sagemath/check/finite-permutation-orbit-enumeration/check.sage
```

各 `check_*.sage` も単独起動できる。

2026-10-12: 統合検算の本文30行は合計777,603確認で通過した。初回は検算の通過後、SageMath の整数を JSON へ直接書き出す処理で失敗した。出力時だけ整数を変換するよう修正し、数学の検査条件を変えずに統合検算を再実行して通過した。統合1本と行別30本の全31ファイルを通常 CLI でそれぞれ起動し、すべて通過した。独立な Lean 具体版・必要十分版・導出版と全体ビルド、2,282宣言の公理依存検査も通過した。

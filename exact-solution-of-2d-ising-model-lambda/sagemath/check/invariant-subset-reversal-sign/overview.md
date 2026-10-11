# 不変部分集合上の反転の符号保存の検算

**対象ラベル**: `claim_invariant_subset_reversal_sign`

2026-10-11 実行済み。31計算行の886,243確認と独立検算、計32ファイルがすべて PASS。

本文の証明にある31計算行を、それぞれ別ファイルで検算する。有限集合の点と符号の演算は整数による厳密計算であり、浮動小数点と実数体への脱出を使わない。

大きさ0〜6の全874置換と全5913個の不変部分集合との組を列挙し、自然順序と二元以上では逆順序も用いた11823事例を対象とする。空の添字集合と空の部分集合を含む。選んだ奇数軌道への適用は、不動点のない置換に奇数軌道が存在する172順序付き事例で検査する。有限例の検算であり、任意の有限集合についての証明は本文とLeanが担う。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_inverse_invariance.sage` | 不変条件を逆像へ適用: $\sigma^{-1}(i)\in C \Longleftrightarrow \sigma(\sigma^{-1}(i))\in C$ | PASS | 68,810 |
| `check_inverse_cancel_membership.sage` | 順逆の相殺による所属の同値: $\sigma(\sigma^{-1}(i))\in C \Longleftrightarrow i\in C$ | PASS | 68,810 |
| `check_pq_inside_q.sage` | 内側の逆順合成で q の定義: $p(q(i))=p(\sigma^{-1}(i))$ | PASS | 34,405 |
| `check_pq_inside_p.sage` | 内側の逆順合成で p の定義: $p(\sigma^{-1}(i))=\sigma(\sigma^{-1}(i))$ | PASS | 34,405 |
| `check_pq_inside_cancel.sage` | 内側の逆順合成で順逆の相殺: $\sigma(\sigma^{-1}(i))=i$ | PASS | 34,405 |
| `check_pq_outside_q.sage` | 外側の逆順合成で q の定義: $p(q(i))=p(i)$ | PASS | 34,405 |
| `check_pq_outside_p.sage` | 外側の逆順合成で p の定義: $p(i)=i$ | PASS | 34,405 |
| `check_qp_inside_p.sage` | 内側の順合成で p の定義: $q(p(i))=q(\sigma(i))$ | PASS | 34,405 |
| `check_qp_inside_q.sage` | 内側の順合成で q の定義: $q(\sigma(i))=\sigma^{-1}(\sigma(i))$ | PASS | 34,405 |
| `check_qp_inside_cancel.sage` | 内側の順合成で逆順の相殺: $\sigma^{-1}(\sigma(i))=i$ | PASS | 34,405 |
| `check_qp_outside_p.sage` | 外側の順合成で p の定義: $q(p(i))=q(i)$ | PASS | 34,405 |
| `check_qp_outside_q.sage` | 外側の順合成で q の定義: $q(i)=i$ | PASS | 34,405 |
| `check_composition_inside_definition.sage` | 内側の合成を点で評価: $(q\circ(q\circ\sigma))(i)=q(q(\sigma(i)))$ | PASS | 34,405 |
| `check_composition_inside_q.sage` | 内側の合成で内側の q を展開: $q(q(\sigma(i)))=q(\sigma^{-1}(\sigma(i)))$ | PASS | 34,405 |
| `check_composition_inside_cancel.sage` | 内側の合成で逆順を相殺: $q(\sigma^{-1}(\sigma(i)))=q(i)$ | PASS | 34,405 |
| `check_composition_inside_outer_q.sage` | 内側の合成で外側の q を展開: $q(i)=\sigma^{-1}(i)$ | PASS | 34,405 |
| `check_composition_inside_reversal.sage` | 内側の反転の定義: $\sigma^{-1}(i)=\tau(i)$ | PASS | 34,405 |
| `check_composition_outside_definition.sage` | 外側の合成を点で評価: $(q\circ(q\circ\sigma))(i)=q(q(\sigma(i)))$ | PASS | 34,405 |
| `check_composition_outside_inner_q.sage` | 外側の合成で内側の q を展開: $q(q(\sigma(i)))=q(\sigma(i))$ | PASS | 34,405 |
| `check_composition_outside_outer_q.sage` | 外側の合成で外側の q を展開: $q(\sigma(i))=\sigma(i)$ | PASS | 34,405 |
| `check_composition_outside_reversal.sage` | 外側の反転の定義: $\sigma(i)=\tau(i)$ | PASS | 34,405 |
| `check_sign_values.sage` | 符号が正負の一に属する: $\mathrm{sgn}(q)\in\{-1,1\}$ | PASS | 11,823 |
| `check_sign_square.sage` | 符号の平方は一: $\mathrm{sgn}(q)\mathrm{sgn}(q)=1$ | PASS | 11,823 |
| `check_sign_composition_identity.sage` | 反転の合成表示を符号に代入: $\mathrm{sgn}(\tau)=\mathrm{sgn}(q\circ(q\circ\sigma))$ | PASS | 11,823 |
| `check_sign_outer_multiplicativity.sage` | 外側の合成に符号の乗法性: $\mathrm{sgn}(q\circ(q\circ\sigma))=\mathrm{sgn}(q)\mathrm{sgn}(q\circ\sigma)$ | PASS | 11,823 |
| `check_sign_inner_multiplicativity.sage` | 内側の合成に符号の乗法性: $\mathrm{sgn}(q)\mathrm{sgn}(q\circ\sigma)=\mathrm{sgn}(q)(\mathrm{sgn}(q)\mathrm{sgn}(\sigma))$ | PASS | 11,823 |
| `check_sign_associativity.sage` | 整数の積の結合則: $\mathrm{sgn}(q)(\mathrm{sgn}(q)\mathrm{sgn}(\sigma))=(\mathrm{sgn}(q)\mathrm{sgn}(q))\mathrm{sgn}(\sigma)$ | PASS | 11,823 |
| `check_sign_square_substitution.sage` | 符号の平方を一へ置換: $(\mathrm{sgn}(q)\mathrm{sgn}(q))\mathrm{sgn}(\sigma)=1\mathrm{sgn}(\sigma)$ | PASS | 11,823 |
| `check_sign_unit.sage` | 整数の積の単位元: $1\mathrm{sgn}(\sigma)=\mathrm{sgn}(\sigma)$ | PASS | 11,823 |
| `check_selected_reversal_definition.sage` | 選んだ奇数軌道の反転の定義: $\mathrm{sgn}(R_{\mathrm{odd}}(\sigma))=\mathrm{sgn}(\rho_{\operatorname{OddOrb}(\sigma)}(\sigma))$ | PASS | 172 |
| `check_selected_reversal_sign.sage` | 選んだ奇数軌道での符号保存: $\mathrm{sgn}(\rho_{\operatorname{OddOrb}(\sigma)}(\sigma))=\mathrm{sgn}(\sigma)$ | PASS | 172 |
| `check_definition.sage` | 両逆・合成表示・符号保存・独立な符号実装との照合 | PASS | 11,823順序付き事例・172奇数軌道事例・空の添字集合1件・空の部分集合1,746件 |

独立検算では符号を転倒数から計算し、Sage の `Permutation.signature()` と照合する。奇数軌道の選択は、順反復で作った軌道を、無向グラフ探索で作った台と突き合わせる。

実行（プロジェクト直下）:

```sh
sage -c "__file__ = 'sagemath/check/invariant-subset-reversal-sign/check.sage'; load(__file__)"
```

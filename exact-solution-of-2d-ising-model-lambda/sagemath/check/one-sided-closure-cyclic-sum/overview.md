# 一側閉包の循環隣接和の四部分反復表示

**対象ラベル**: `claim_one_sided_closure_cyclic_sum`

整数格子上の四つの点列から閉包を組み立て、その隣接差を固定四部分列へ一つずつ置換する。
三接合を含む実際の点列を整数除法で構成し、単位歩を積み上げた独立の点列とも照合する。
最後に内部和と閉じ目を別々に置換する。一般の周期数の証明は Lean が担う。

| ファイル | 対象の行 | 状態 |
|---|---|---|
| `check_lift_repetition.sage` | A_c(j) = u(j mod m) | PASS |
| `check_upper_fixed.sage` | V_c(i) = v(i) | PASS |
| `check_return_repetition.sage` | R_c(s) = r(s mod n) | PASS |
| `check_lower_fixed.sage` | X_c(i) = x(i) | PASS |
| `check_selected_index_bounds.sage` | 四区間が選ぶ局所添字の範囲 | PASS |
| `check_step_four_parts.sage` | w_j = J(A_c,V_c,R_c,X_c)_j | PASS |
| `check_substitute_lift.sage` | J(A_c,V_c,R_c,X_c)_j = J(U,V_c,R_c,X_c)_j | PASS |
| `check_substitute_upper.sage` | J(U,V_c,R_c,X_c)_j = J(U,v,R_c,X_c)_j | PASS |
| `check_substitute_return.sage` | J(U,v,R_c,X_c)_j = J(U,v,R,X_c)_j | PASS |
| `check_substitute_lower.sage` | J(U,v,R,X_c)_j = J(U,v,R,x)_j | PASS |
| `check_cyclic_definition.sage` | C(w) = I(w) + vartheta(w_last,w_first) | PASS |
| `check_internal_substitution.sage` | I(w) + vartheta(w_last,w_first) = I(z) + vartheta(w_last,w_first) | PASS |
| `check_closing_substitution.sage` | I(z) + vartheta(w_last,w_first) = I(z) + vartheta(z_last,z_first) | PASS |
| `check_cyclic_fold.sage` | I(z) + vartheta(z_last,z_first) = C(z) | PASS |
| `check_independent_points.sage` | 単位歩を加えて構成した閉点列との全歩・循環和の一致 | PASS |

実行: `sage sagemath/check/one-sided-closure-cyclic-sum/check.sage`

2026-10-04 実行: 3,072個の閉点列を検査した。
辺長一から三、零でない巻き付き各成分 −1・0・1、二つの基点、負の基点添字、
周期長一、二つの横断反復数、周期数一から四を含む。
周期持ち上げ30,720歩・平行帰路23,040歩・横断二列各6,912歩、
区間選択と全歩の各置換67,584歩、各循環和と独立点列3,072例が全件通過した。
検算には後退を含む点列も入るが、この同定に非後退性は必要ない。

Lean 具体版は三接合を実際の端点から導き、四区間の歩を置換してから内部和と閉じ目を同定する。
必要十分版は点と歩の型に構造を要求せず、任意の歩の写像と可換加法モノイド値の重みを使う。
導出版はそれらを整数格子の差と整数の回転の重みへ特殊化する。

# SageMath Check: 境界頂点での対角接触の排除

**対象ラベル**: `claim_boundary_vertex_diagonal_contact_excluded`

頂点単純な閉じた非後退単位格子歩について、外接長方形を 1 だけ広げた窓の各格子点に接する
四セルの内側の別を右半直線交差の奇偶で判定し、内側セルの集合が対角の二セルだけになる配置
（$\{C_0,C_2\}$ と $\{C_1,C_3\}$）が現れないことを検査する。

- 実行: `sage sagemath/check/no-diagonal-only-contact/check.sage`
- 状態: PASS（2026-08-31）。長さ $10$ 以下の頂点単純閉歩道 704 本、格子点 20,096 個を検査した。
- 計算: 有限の数え上げと `ZZ` の四則・奇偶だけ。浮動小数点は使わない。

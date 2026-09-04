import { defineBlocks, paragraph, ref } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "neg_ref",
    kind: "claim",
    labels: [],
    habitat: "N",
    statement: [paragraph(["参照: ", ref("claim_adjacent_cells_ray_crossing_difference__does_not_exist")])],
  },
]);

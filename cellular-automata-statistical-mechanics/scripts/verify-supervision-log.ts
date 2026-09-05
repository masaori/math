import { verifyProject } from "../../scripts/research-supervision/verify.ts";
await verifyProject("cellular-automata-statistical-mechanics", process.argv[2], false).then(() => console.log("プログラミングによる検証: セルオートマトンの監督記録を受理")).catch(error => { console.error(String(error)); process.exitCode = 1; });

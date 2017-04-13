
DECLARE
   l_errbuf       VARCHAR2 (20000);
   l_retcode      NUMBER;
   l_batch_id     NUMBER;
   l_request_id   NUMBER;
   ls_info        xla_events_pub_pkg.t_event_source_info;
BEGIN
   FOR c
      IN (SELECT   x.entity_id
              FROM ap_invoice_distributions_all dsa, xla_events x
             WHERE invoice_id = 2278472
                   AND x.event_id = dsa.accounting_event_id
          GROUP BY x.entity_id)
   LOOP
      XLA_ACCOUNTING_PUB_PKG.accounting_program_document (
         p_event_source_info     => ls_info,
         p_entity_id             => c.entity_id,
         p_accounting_flag       => 'Y',
         p_accounting_mode       => 'D',
         p_transfer_flag         => 'N',
         p_gl_posting_flag       => 'N',
         p_offline_flag          => 'N',
         p_accounting_batch_id   => l_batch_id,
         p_errbuf                => l_errbuf,
         p_retcode               => l_retcode,
         p_request_id            => l_request_id);
   END LOOP;
   COMMIT;
   dbms_output.put_line('l_request_id '||l_request_id);
END;

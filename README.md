# Telegraf plugin: zswap

A telegraf plugin for zswap statistics

zswap is a Linux kernel feature that provides a compressed write-back cache for swapped pages, as a form of virtual memory compression. Instead of moving memory pages to a swap device when they are to be swapped out, zswap performs their compression and then stores them into a memory pool dynamically allocated in the system RAM. Later writeback to the actual swap device is deferred or even completely avoided, resulting in a significantly reduced I/O for Linux systems that require swapping; the tradeoff is the need for additional CPU cycles to perform the compression.

# Grafana screenshot

![Grafana screenshot zswap](https://github.com/dkruyt/telegraf-zswap/raw/master/screenshot-grafana-zswap.jpg)

# Measurements

Measurement names:

- duplicate_entry
- pool_limit_hit
- pool_total_size
- reject_alloc_fail
- reject_compress_poor
- reject_kmemcache_fail
- reject_reclaim_fail
- stored_pages
- written_back_pages

### Description

```
pool_pages - number pages backing the compressed memory pool
reject_compress_poor - reject pages due to poor compression policy (cumulative) (see max_compressed_page_size sysfs attribute)
reject_zsmalloc_fail - rejected pages due to zsmalloc failure (cumulative)
reject_kmemcache_fail - rejected pages due to kmem failure (cumulative)
reject_tmppage_fail - rejected pages due to tmppage failure (cumulative)
reject_flush_attempted - reject flush attempted (cumulative)
reject_flush_fail - reject flush failed (cumulative)
stored_pages - number of compressed pages stored in zswap
outstanding_flushes - the number of pages queued to be written back
flushed_pages - the number of pages written back from zswap to the swap device (cumulative)
saved_by_flush - the number of stores that succeeded after an initial failure due to reclaim by flushing pages to the swap device
pool_limit_hit - the zswap pool limit has been reached
```

# Example output

Using this configuration:

```
[[inputs.exec]]
  commands = ["sudo /etc/telegraf/telegraf.d/zswap.sh"]

  ## Timeout for each command to complete.
  timeout = "5s"

  # Data format to consume.
  # NOTE json only reads numerical measurements, strings and booleans are ignored.
  data_format = "influx"
```

Make sure you put the next part in /etc/sudoers

```
telegraf ALL = NOPASSWD: /etc/telegraf/telegraf.d/zswap.sh
```

When run with:

```
telegraf --test --config /etc/telegraf/telegraf.d/zswap.conf
```

It produces:

```
* Plugin: inputs.exec, Collection 1
> zswap,host=birdofprey pool_limit_hit=0,reject_kmemcache_fail=0,stored_pages=62742,written_back_pages=0,reject_reclaim_fail=0,duplicate_entry=0,pool_total_size=128495616,reject_alloc_fail=0,reject_compress_poor=2762 1498400744000000000
```

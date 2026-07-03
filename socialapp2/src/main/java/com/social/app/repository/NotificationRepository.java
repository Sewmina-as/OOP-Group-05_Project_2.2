package com.social.app.repository;

import com.social.app.model.Notification;
import com.social.app.NotificationType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    /** Most recent notifications for the navbar dropdown (capped via Pageable). */
    List<Notification> findByRecipientIdOrderByCreatedAtDesc(Long recipientId, Pageable pageable);

    /** Full paginated history for a "View all notifications" page. */
    Page<Notification> findByRecipientId(Long recipientId, Pageable pageable);

    long countByRecipientIdAndReadFalse(Long recipientId);

    @Transactional
    @Modifying
    @Query("UPDATE Notification n SET n.read = true WHERE n.recipient.id = :userId AND n.read = false")
    void markAllAsRead(@Param("userId") Long userId);

    @Transactional
    @Modifying
    @Query("UPDATE Notification n SET n.read = true WHERE n.id = :id AND n.recipient.id = :userId")
    void markAsRead(@Param("id") Long id, @Param("userId") Long userId);

    /** Avoid duplicate LIKE notifications on rapid like/unlike/like. */
    boolean existsByRecipientIdAndActorIdAndTypeAndPostId(
            Long recipientId, Long actorId, NotificationType type, Long postId);
}
